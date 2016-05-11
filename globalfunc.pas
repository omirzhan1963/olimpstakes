unit globalfunc;

interface

uses
  classes,variants,mshtml,SHDocVw, sysutils;
  type
     attr=record
       name:string;
       value:string;
     end;
  attrs=array of attr;
     evst=record
      idevent:integer;
      idstaketype:integer;
       stakevalue:real;
       margin:real;
     end;
     evstar=array of evst;
      betstake=record
    id_event:integer;
    id_staketype:integer;
    stval:real;
    settled:boolean;
    won:boolean;

  end;
  betstakear=array of  betstake;
  betrecord=record
  settledtimestr:string;
    betnum:integer;
    betsum:integer;
    betresult:integer;
    bstakear:betstakear;
  end;
   livechamp=record
     name:string;
     id:integer;
   end;
   livechampar=array of livechamp;

   liveevent=record
     id_champ:integer;
     name:string;
     id_event:integer;

   end;
   liveeventar=array of liveevent;
   livestakegroup=record
     name:string;
     id:integer;
   end;
       livestakegroupar=array of livestakegroup;
       livestaketype=record
         name:string;
         id:integer;
         id_event:integer;
       end;
       livestaketypear=array of livestaketype;
  timeofnav=(anytime,nexttwohour,nextsixhour,nexttvelwehour,nextday);
  tprocedure=procedure(millisec:integer);
  ari=array of integer;
   init_class=class

  wb:twebbrowser;
wait:tprocedure;



    end;
     doc2=ihtmldocument2;
icol=ihtmlelementcollection;
iel=ihtmlelement;

function isrestrictedmainchild(chel,mainel:iel):boolean;
      function isolimpdate(s:string):boolean;
  function inari(index:integer;ar:ari):boolean;
  function isdigit(c:char):boolean;
   function getattr(elem:ihtmlelement):attrs;
   function hasattrs(el:ihtmlelement;at:attrs):boolean;
    function strisint(s:string):boolean;
    function ismainchild(parentel,childel:ihtmlelement):boolean;
       function transformdate(s:string):string;
       const
       br:string=char(13)+char(10);
implementation

 function isrestrictedmainchild(chel,mainel:iel):boolean;
  var
tempel:iel;
tname:string;
childname,parentname:string;
 begin
 result:=false;
 childname:=chel.tagName;
  parentname:=mainel.tagName;
 tempel:=chel.parentElement;
  tname:=tempel.tagName;
  while tname<>parentname do
   begin
   if tname='HTML' then  exit;
   if tname=childname then exit;
   tempel:=tempel.parentElement;
   tname:=tempel.tagName;

   end;
   if tempel=mainel then result:=true;


 end;

    function isolimpdate(s:string):boolean;
  begin
    result:=false;
    if length(s)<>16 then exit;

    if not isdigit(s[1]) then  exit;
     if not isdigit(s[2]) then  exit;
      if s[3]<>'.' then  exit;

       if not isdigit(s[4]) then  exit;
      if not isdigit(s[5]) then  exit;
          if s[6]<>'.' then  exit;
         if not isdigit(s[7]) then  exit;
        if not isdigit(s[8]) then  exit;
         if not isdigit(s[9]) then  exit;
           if not isdigit(s[10]) then  exit;
              if s[11]<>' ' then  exit;
          if not isdigit(s[12]) then  exit;
           if not isdigit(s[13]) then  exit;
                 if s[14]<>':' then  exit;
            if not isdigit(s[15]) then  exit;
             if not isdigit(s[16]) then  exit;
             result:=true;
  end;

  function getattr(elem:ihtmlelement):attrs;
var nn:OleVariant;
j,i,cnt,cntattr:integer;
 p:Pointer;
 domnode:IHTMLDOMNode;

    collection:ihtmlelementcollection;

   attrs:IHTMLAttributeCollection;
   atr:IHTMLDOMAttribute;
   aName,aVal:String;
  begin

  setlength(result,0);


      if elem.QueryInterface(IID_IHTMLDOMNode,p)=S_OK then begin
        domnode:=IHTMLDOMNode(p);
        aname:=domnode.nodeName;
        aval:=Elem.innerHTML;
        //****************************** Attributes *********************************************

           if domnode.attributes.QueryInterface(IID_IHTMLAttributeCollection,p)=S_OK then begin
            attrs:=IHTMLAttributeCollection(p);
            cntattr:=attrs.length;
            for j:=0 to cntattr-1 do begin
              nn:=j;
              if attrs.item(nn).QueryInterface(IID_IHTMLDOMAttribute,p)=S_OK then begin
                atr:=IHTMLDOMAttribute(p);
                if not VarIsNull(atr.nodeValue) then begin
                  aName:=atr.nodeName;
                  aVal:=trim(VarToStrDef(atr.nodeValue,''));
                  if (aVal<>'') then begin

  setlength(result,length(result)+1);
  result[length(result)-1].name:=aname;
  result[length(result)-1].value:=aval;

                    // ListBox.Items.Append(aName+'='+aVal);
                  end;
                end;
              end;
            end;
           end;
          end;
        //***************************************************************************************
       end;
  function isdigit(c:char):boolean;
 begin
   result:=false;
   if ((ord(c)>47) and (ord(c)<58)) then  result:=true;

 end;
  function inari(index:integer;ar:ari):boolean;
  var
  i,arilength:integer;
  begin
  result:=false;
  arilength:=length(ar);
  for I := 0 to arilength-1 do
   if index=ar[i] then
   begin
    result:=true;
    exit;
   end;




  end;
    function hasattrs(el:ihtmlelement;at:attrs):boolean;
    var
    i,j,k,l:integer;
    tempattrs:attrs;
    sn,sv:string;
    begin
    result:=false;
      j:=length(at);
      if j=0 then   exit;
      tempattrs:=getattr(el);
      k:=0;
      for I := 0 to length(tempattrs)-1 do
      begin
       sn:=tempattrs[i].name;
       sv:=tempattrs[i].value;
       for l := 0 to j-1 do
         if ((at[l].name=sn) and (at[l].value=sv)) then
           k:=k+1;
           if k=j then
           begin
             result:=true;
             exit;
           end;
      end;


    end;
       function strisint(s:string):boolean;
         var
         i:integer;
       begin
         result:=false;
         if length(s)=0 then  exit;

         while length(s)>0 do
           begin
             if not isdigit(s[1]) then

                exit;

               delete(s,1,1);
           end;
           result:=true;
       end;
            function ismainchild(parentel,childel:ihtmlelement):boolean;
            var
            tagname:string;
            tempparent:ihtmlelement;
            mainindex:integer;
            begin
              tagname:=parentel.tagname;
              mainindex:=parentel.sourceIndex;

                 tempparent:=childel.parentElement;
 result:=false;
 while  tempparent.tagName<>'HTML' do
 begin
 if (( tempparent.tagName=tagname) and ( tempparent.sourceIndex<>mainindex)) then
   begin
     exit;
   end;
   if  tempparent.sourceIndex=mainindex then
    begin
      result:=true;
      exit;
    end;
  tempparent:= tempparent.parentElement;
 end;

            end;
   function transformdate(s:string):string;
  begin

    result:=copy(s,7,4)+'-'+copy(s,4,2)+'-'+copy(s,1,2)+' '+copy(s,12,5)+':00.000';

  end;
end.

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
  timeofnav=(anytime,nexttwohour,nextsixhour,nexttvelwehour,nextday);
  tprocedure=procedure(millisec:integer);
  ari=array of integer;
   init_class=class

  wb:twebbrowser;
wait:tprocedure;



    end;
  function inari(index:integer;ar:ari):boolean;
  function isdigit(c:char):boolean;
   function getattr(elem:ihtmlelement):attrs;
   function hasattrs(el:ihtmlelement;at:attrs):boolean;

implementation
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

end.

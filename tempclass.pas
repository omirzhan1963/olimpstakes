unit tempclass;

interface

type
  tempclass = class
  end;

  IPrototype = interface
    function Clone: IPrototype;
  end;

  TConcretePrototype = class(TInterfacedObject, IPrototype)
  strict protected
    constructor Create(APrototype: TConcretePrototype);
  public
    function Clone: IPrototype;
  end;

implementation

constructor TConcretePrototype.Create(APrototype: TConcretePrototype);
begin
  inherited Create;
end;

function TConcretePrototype.Clone: IPrototype;
begin
  Result := TConcretePrototype.Create(self);
end;

end.

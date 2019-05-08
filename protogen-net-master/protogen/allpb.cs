//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// Generated from: allpb.proto
namespace allpb
{
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"PlayerInfo")]
  public partial class PlayerInfo : global::ProtoBuf.IExtensible
  {
    public PlayerInfo() {}
    
    private int _userId;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"userId", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int userId
    {
      get { return _userId; }
      set { _userId = value; }
    }
    private int _playerId;
    [global::ProtoBuf.ProtoMember(2, IsRequired = true, Name=@"playerId", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int playerId
    {
      get { return _playerId; }
      set { _playerId = value; }
    }
    private string _playerName;
    [global::ProtoBuf.ProtoMember(3, IsRequired = true, Name=@"playerName", DataFormat = global::ProtoBuf.DataFormat.Default)]
    public string playerName
    {
      get { return _playerName; }
      set { _playerName = value; }
    }
    private int _coin;
    [global::ProtoBuf.ProtoMember(4, IsRequired = true, Name=@"coin", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int coin
    {
      get { return _coin; }
      set { _coin = value; }
    }
    private int _nowUseShape;
    [global::ProtoBuf.ProtoMember(5, IsRequired = true, Name=@"nowUseShape", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int nowUseShape
    {
      get { return _nowUseShape; }
      set { _nowUseShape = value; }
    }
    private readonly global::System.Collections.Generic.List<int> _allShape = new global::System.Collections.Generic.List<int>();
    [global::ProtoBuf.ProtoMember(6, Name=@"allShape", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public global::System.Collections.Generic.List<int> allShape
    {
      get { return _allShape; }
    }
  
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"LoginRequest")]
  public partial class LoginRequest : global::ProtoBuf.IExtensible
  {
    public LoginRequest() {}
    
    private string _username;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"username", DataFormat = global::ProtoBuf.DataFormat.Default)]
    public string username
    {
      get { return _username; }
      set { _username = value; }
    }
    private string _password;
    [global::ProtoBuf.ProtoMember(2, IsRequired = true, Name=@"password", DataFormat = global::ProtoBuf.DataFormat.Default)]
    public string password
    {
      get { return _password; }
      set { _password = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"LoginResponse")]
  public partial class LoginResponse : global::ProtoBuf.IExtensible
  {
    public LoginResponse() {}
    
    private int _succ;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"succ", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int succ
    {
      get { return _succ; }
      set { _succ = value; }
    }
    private PlayerInfo _playerInfo;
    [global::ProtoBuf.ProtoMember(2, IsRequired = true, Name=@"playerInfo", DataFormat = global::ProtoBuf.DataFormat.Default)]
    public PlayerInfo playerInfo
    {
      get { return _playerInfo; }
      set { _playerInfo = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"TipsMessage")]
  public partial class TipsMessage : global::ProtoBuf.IExtensible
  {
    public TipsMessage() {}
    
    private string _tips;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"tips", DataFormat = global::ProtoBuf.DataFormat.Default)]
    public string tips
    {
      get { return _tips; }
      set { _tips = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"UseShapeRequest")]
  public partial class UseShapeRequest : global::ProtoBuf.IExtensible
  {
    public UseShapeRequest() {}
    
    private int _shape;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"shape", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int shape
    {
      get { return _shape; }
      set { _shape = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"UseShapeResponse")]
  public partial class UseShapeResponse : global::ProtoBuf.IExtensible
  {
    public UseShapeResponse() {}
    
    private int _succ;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"succ", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int succ
    {
      get { return _succ; }
      set { _succ = value; }
    }
    private int _nowUseShape;
    [global::ProtoBuf.ProtoMember(2, IsRequired = true, Name=@"nowUseShape", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int nowUseShape
    {
      get { return _nowUseShape; }
      set { _nowUseShape = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"BuyShapeRequest")]
  public partial class BuyShapeRequest : global::ProtoBuf.IExtensible
  {
    public BuyShapeRequest() {}
    
    private int _shape;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"shape", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int shape
    {
      get { return _shape; }
      set { _shape = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"BuyShapeResponse")]
  public partial class BuyShapeResponse : global::ProtoBuf.IExtensible
  {
    public BuyShapeResponse() {}
    
    private int _succ;
    [global::ProtoBuf.ProtoMember(1, IsRequired = true, Name=@"succ", DataFormat = global::ProtoBuf.DataFormat.TwosComplement)]
    public int succ
    {
      get { return _succ; }
      set { _succ = value; }
    }
    private PlayerInfo _playerInfo;
    [global::ProtoBuf.ProtoMember(2, IsRequired = true, Name=@"playerInfo", DataFormat = global::ProtoBuf.DataFormat.Default)]
    public PlayerInfo playerInfo
    {
      get { return _playerInfo; }
      set { _playerInfo = value; }
    }
    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
      { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }
  
}
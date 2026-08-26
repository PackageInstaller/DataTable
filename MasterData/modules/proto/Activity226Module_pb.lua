-- chunkname: @modules/proto/Activity226Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity226Module_pb", package.seeall)

local Activity226Module_pb = {}

Activity226Module_pb.ACT226PAGENO_MSG = protobuf.Descriptor()
Activity226Module_pb.ACT226PAGENOPAGEFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG = protobuf.Descriptor()
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.GETACT226INFOREQUEST_MSG = protobuf.Descriptor()
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.GETACT226INFOREPLY_MSG = protobuf.Descriptor()
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG = protobuf.Descriptor()
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.ACT226POSNO_MSG = protobuf.Descriptor()
Activity226Module_pb.ACT226POSNOPOSFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.ACT226POSNOBONUSIDFIELD = protobuf.FieldDescriptor()
Activity226Module_pb.ACT226PAGENOPAGEFIELD.name = "page"
Activity226Module_pb.ACT226PAGENOPAGEFIELD.full_name = ".Act226PageNO.page"
Activity226Module_pb.ACT226PAGENOPAGEFIELD.number = 1
Activity226Module_pb.ACT226PAGENOPAGEFIELD.index = 0
Activity226Module_pb.ACT226PAGENOPAGEFIELD.label = 1
Activity226Module_pb.ACT226PAGENOPAGEFIELD.has_default_value = false
Activity226Module_pb.ACT226PAGENOPAGEFIELD.default_value = 0
Activity226Module_pb.ACT226PAGENOPAGEFIELD.type = 5
Activity226Module_pb.ACT226PAGENOPAGEFIELD.cpp_type = 1
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.name = "hasGetPoss"
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.full_name = ".Act226PageNO.hasGetPoss"
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.number = 2
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.index = 1
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.label = 3
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.has_default_value = false
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.default_value = {}
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.message_type = Activity226Module_pb.ACT226POSNO_MSG
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.type = 11
Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD.cpp_type = 10
Activity226Module_pb.ACT226PAGENO_MSG.name = "Act226PageNO"
Activity226Module_pb.ACT226PAGENO_MSG.full_name = ".Act226PageNO"
Activity226Module_pb.ACT226PAGENO_MSG.nested_types = {}
Activity226Module_pb.ACT226PAGENO_MSG.enum_types = {}
Activity226Module_pb.ACT226PAGENO_MSG.fields = {
	Activity226Module_pb.ACT226PAGENOPAGEFIELD,
	Activity226Module_pb.ACT226PAGENOHASGETPOSSFIELD
}
Activity226Module_pb.ACT226PAGENO_MSG.is_extendable = false
Activity226Module_pb.ACT226PAGENO_MSG.extensions = {}
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.full_name = ".ReceiveAct226BonusRequest.activityId"
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.name = "pos"
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.full_name = ".ReceiveAct226BonusRequest.pos"
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.number = 2
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.index = 1
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.label = 1
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.has_default_value = false
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.default_value = 0
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.type = 5
Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD.cpp_type = 1
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.name = "ReceiveAct226BonusRequest"
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.full_name = ".ReceiveAct226BonusRequest"
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.nested_types = {}
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.enum_types = {}
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.fields = {
	Activity226Module_pb.RECEIVEACT226BONUSREQUESTACTIVITYIDFIELD,
	Activity226Module_pb.RECEIVEACT226BONUSREQUESTPOSFIELD
}
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.is_extendable = false
Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG.extensions = {}
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct226InfoRequest.activityId"
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.number = 1
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.index = 0
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.label = 1
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.type = 5
Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity226Module_pb.GETACT226INFOREQUEST_MSG.name = "GetAct226InfoRequest"
Activity226Module_pb.GETACT226INFOREQUEST_MSG.full_name = ".GetAct226InfoRequest"
Activity226Module_pb.GETACT226INFOREQUEST_MSG.nested_types = {}
Activity226Module_pb.GETACT226INFOREQUEST_MSG.enum_types = {}
Activity226Module_pb.GETACT226INFOREQUEST_MSG.fields = {
	Activity226Module_pb.GETACT226INFOREQUESTACTIVITYIDFIELD
}
Activity226Module_pb.GETACT226INFOREQUEST_MSG.is_extendable = false
Activity226Module_pb.GETACT226INFOREQUEST_MSG.extensions = {}
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct226InfoReply.activityId"
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.number = 1
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.index = 0
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.label = 1
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.type = 5
Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.name = "pages"
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.full_name = ".GetAct226InfoReply.pages"
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.number = 2
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.index = 1
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.label = 3
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.has_default_value = false
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.default_value = {}
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.message_type = Activity226Module_pb.ACT226PAGENO_MSG
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.type = 11
Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD.cpp_type = 10
Activity226Module_pb.GETACT226INFOREPLY_MSG.name = "GetAct226InfoReply"
Activity226Module_pb.GETACT226INFOREPLY_MSG.full_name = ".GetAct226InfoReply"
Activity226Module_pb.GETACT226INFOREPLY_MSG.nested_types = {}
Activity226Module_pb.GETACT226INFOREPLY_MSG.enum_types = {}
Activity226Module_pb.GETACT226INFOREPLY_MSG.fields = {
	Activity226Module_pb.GETACT226INFOREPLYACTIVITYIDFIELD,
	Activity226Module_pb.GETACT226INFOREPLYPAGESFIELD
}
Activity226Module_pb.GETACT226INFOREPLY_MSG.is_extendable = false
Activity226Module_pb.GETACT226INFOREPLY_MSG.extensions = {}
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.full_name = ".ReceiveAct226BonusReply.activityId"
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.number = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.index = 0
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.label = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.type = 5
Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.name = "pos"
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.full_name = ".ReceiveAct226BonusReply.pos"
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.number = 2
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.index = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.label = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.has_default_value = false
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.default_value = 0
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.type = 5
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD.cpp_type = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.name = "posInfo"
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.full_name = ".ReceiveAct226BonusReply.posInfo"
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.number = 3
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.index = 2
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.label = 1
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.has_default_value = false
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.default_value = nil
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.message_type = Activity226Module_pb.ACT226POSNO_MSG
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.type = 11
Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD.cpp_type = 10
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.name = "ReceiveAct226BonusReply"
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.full_name = ".ReceiveAct226BonusReply"
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.nested_types = {}
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.enum_types = {}
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.fields = {
	Activity226Module_pb.RECEIVEACT226BONUSREPLYACTIVITYIDFIELD,
	Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSFIELD,
	Activity226Module_pb.RECEIVEACT226BONUSREPLYPOSINFOFIELD
}
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.is_extendable = false
Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG.extensions = {}
Activity226Module_pb.ACT226POSNOPOSFIELD.name = "pos"
Activity226Module_pb.ACT226POSNOPOSFIELD.full_name = ".Act226PosNO.pos"
Activity226Module_pb.ACT226POSNOPOSFIELD.number = 1
Activity226Module_pb.ACT226POSNOPOSFIELD.index = 0
Activity226Module_pb.ACT226POSNOPOSFIELD.label = 1
Activity226Module_pb.ACT226POSNOPOSFIELD.has_default_value = false
Activity226Module_pb.ACT226POSNOPOSFIELD.default_value = 0
Activity226Module_pb.ACT226POSNOPOSFIELD.type = 5
Activity226Module_pb.ACT226POSNOPOSFIELD.cpp_type = 1
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.name = "bonusId"
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.full_name = ".Act226PosNO.bonusId"
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.number = 2
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.index = 1
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.label = 1
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.has_default_value = false
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.default_value = 0
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.type = 5
Activity226Module_pb.ACT226POSNOBONUSIDFIELD.cpp_type = 1
Activity226Module_pb.ACT226POSNO_MSG.name = "Act226PosNO"
Activity226Module_pb.ACT226POSNO_MSG.full_name = ".Act226PosNO"
Activity226Module_pb.ACT226POSNO_MSG.nested_types = {}
Activity226Module_pb.ACT226POSNO_MSG.enum_types = {}
Activity226Module_pb.ACT226POSNO_MSG.fields = {
	Activity226Module_pb.ACT226POSNOPOSFIELD,
	Activity226Module_pb.ACT226POSNOBONUSIDFIELD
}
Activity226Module_pb.ACT226POSNO_MSG.is_extendable = false
Activity226Module_pb.ACT226POSNO_MSG.extensions = {}
Activity226Module_pb.Act226PageNO = protobuf.Message(Activity226Module_pb.ACT226PAGENO_MSG)
Activity226Module_pb.Act226PosNO = protobuf.Message(Activity226Module_pb.ACT226POSNO_MSG)
Activity226Module_pb.GetAct226InfoReply = protobuf.Message(Activity226Module_pb.GETACT226INFOREPLY_MSG)
Activity226Module_pb.GetAct226InfoRequest = protobuf.Message(Activity226Module_pb.GETACT226INFOREQUEST_MSG)
Activity226Module_pb.ReceiveAct226BonusReply = protobuf.Message(Activity226Module_pb.RECEIVEACT226BONUSREPLY_MSG)
Activity226Module_pb.ReceiveAct226BonusRequest = protobuf.Message(Activity226Module_pb.RECEIVEACT226BONUSREQUEST_MSG)

return Activity226Module_pb

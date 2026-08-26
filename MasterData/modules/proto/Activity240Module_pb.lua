-- chunkname: @modules/proto/Activity240Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity240Module_pb", package.seeall)

local Activity240Module_pb = {}

Activity240Module_pb.ACT240SIGNINREQUEST_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240GETINFOREPLY_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240INFO_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240INFOIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240INFOSTATEFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240GETINFOREQUEST_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240BACKDATEREPLY_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240SIGNINREPLY_MSG = protobuf.Descriptor()
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD = protobuf.FieldDescriptor()
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.name = "activityId"
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.full_name = ".Act240SignInRequest.activityId"
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.number = 1
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.index = 0
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.label = 1
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.default_value = 0
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.type = 5
Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.name = "Act240SignInRequest"
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.full_name = ".Act240SignInRequest"
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.nested_types = {}
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.enum_types = {}
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.fields = {
	Activity240Module_pb.ACT240SIGNINREQUESTACTIVITYIDFIELD
}
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.is_extendable = false
Activity240Module_pb.ACT240SIGNINREQUEST_MSG.extensions = {}
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.full_name = ".Act240GetInfoReply.activityId"
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.number = 1
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.index = 0
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.label = 1
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.default_value = 0
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.type = 5
Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.name = "openDay"
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.full_name = ".Act240GetInfoReply.openDay"
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.number = 2
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.index = 1
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.label = 1
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.has_default_value = false
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.default_value = 0
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.type = 5
Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD.cpp_type = 1
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.name = "todaySigned"
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.full_name = ".Act240GetInfoReply.todaySigned"
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.number = 3
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.index = 2
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.label = 1
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.has_default_value = false
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.default_value = false
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.type = 8
Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD.cpp_type = 7
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.name = "infos"
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.full_name = ".Act240GetInfoReply.infos"
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.number = 4
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.index = 3
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.label = 3
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.has_default_value = false
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.default_value = {}
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.message_type = Activity240Module_pb.ACT240INFO_MSG
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.type = 11
Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD.cpp_type = 10
Activity240Module_pb.ACT240GETINFOREPLY_MSG.name = "Act240GetInfoReply"
Activity240Module_pb.ACT240GETINFOREPLY_MSG.full_name = ".Act240GetInfoReply"
Activity240Module_pb.ACT240GETINFOREPLY_MSG.nested_types = {}
Activity240Module_pb.ACT240GETINFOREPLY_MSG.enum_types = {}
Activity240Module_pb.ACT240GETINFOREPLY_MSG.fields = {
	Activity240Module_pb.ACT240GETINFOREPLYACTIVITYIDFIELD,
	Activity240Module_pb.ACT240GETINFOREPLYOPENDAYFIELD,
	Activity240Module_pb.ACT240GETINFOREPLYTODAYSIGNEDFIELD,
	Activity240Module_pb.ACT240GETINFOREPLYINFOSFIELD
}
Activity240Module_pb.ACT240GETINFOREPLY_MSG.is_extendable = false
Activity240Module_pb.ACT240GETINFOREPLY_MSG.extensions = {}
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.full_name = ".Act240BackdateRequest.activityId"
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.number = 1
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.index = 0
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.label = 1
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.default_value = 0
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.type = 5
Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.name = "Act240BackdateRequest"
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.full_name = ".Act240BackdateRequest"
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.nested_types = {}
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.enum_types = {}
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.fields = {
	Activity240Module_pb.ACT240BACKDATEREQUESTACTIVITYIDFIELD
}
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.is_extendable = false
Activity240Module_pb.ACT240BACKDATEREQUEST_MSG.extensions = {}
Activity240Module_pb.ACT240INFOIDFIELD.name = "id"
Activity240Module_pb.ACT240INFOIDFIELD.full_name = ".Act240Info.id"
Activity240Module_pb.ACT240INFOIDFIELD.number = 1
Activity240Module_pb.ACT240INFOIDFIELD.index = 0
Activity240Module_pb.ACT240INFOIDFIELD.label = 1
Activity240Module_pb.ACT240INFOIDFIELD.has_default_value = false
Activity240Module_pb.ACT240INFOIDFIELD.default_value = 0
Activity240Module_pb.ACT240INFOIDFIELD.type = 5
Activity240Module_pb.ACT240INFOIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240INFOSTATEFIELD.name = "state"
Activity240Module_pb.ACT240INFOSTATEFIELD.full_name = ".Act240Info.state"
Activity240Module_pb.ACT240INFOSTATEFIELD.number = 2
Activity240Module_pb.ACT240INFOSTATEFIELD.index = 1
Activity240Module_pb.ACT240INFOSTATEFIELD.label = 1
Activity240Module_pb.ACT240INFOSTATEFIELD.has_default_value = false
Activity240Module_pb.ACT240INFOSTATEFIELD.default_value = 0
Activity240Module_pb.ACT240INFOSTATEFIELD.type = 5
Activity240Module_pb.ACT240INFOSTATEFIELD.cpp_type = 1
Activity240Module_pb.ACT240INFO_MSG.name = "Act240Info"
Activity240Module_pb.ACT240INFO_MSG.full_name = ".Act240Info"
Activity240Module_pb.ACT240INFO_MSG.nested_types = {}
Activity240Module_pb.ACT240INFO_MSG.enum_types = {}
Activity240Module_pb.ACT240INFO_MSG.fields = {
	Activity240Module_pb.ACT240INFOIDFIELD,
	Activity240Module_pb.ACT240INFOSTATEFIELD
}
Activity240Module_pb.ACT240INFO_MSG.is_extendable = false
Activity240Module_pb.ACT240INFO_MSG.extensions = {}
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.full_name = ".Act240GetInfoRequest.activityId"
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.number = 1
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.index = 0
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.label = 1
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.type = 5
Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.name = "Act240GetInfoRequest"
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.full_name = ".Act240GetInfoRequest"
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.nested_types = {}
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.enum_types = {}
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.fields = {
	Activity240Module_pb.ACT240GETINFOREQUESTACTIVITYIDFIELD
}
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.is_extendable = false
Activity240Module_pb.ACT240GETINFOREQUEST_MSG.extensions = {}
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.name = "activityId"
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.full_name = ".Act240BackdateReply.activityId"
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.number = 1
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.index = 0
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.label = 1
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.default_value = 0
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.type = 5
Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.name = "ids"
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.full_name = ".Act240BackdateReply.ids"
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.number = 2
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.index = 1
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.label = 3
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.has_default_value = false
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.default_value = {}
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.type = 5
Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD.cpp_type = 1
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.name = "Act240BackdateReply"
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.full_name = ".Act240BackdateReply"
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.nested_types = {}
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.enum_types = {}
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.fields = {
	Activity240Module_pb.ACT240BACKDATEREPLYACTIVITYIDFIELD,
	Activity240Module_pb.ACT240BACKDATEREPLYIDSFIELD
}
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.is_extendable = false
Activity240Module_pb.ACT240BACKDATEREPLY_MSG.extensions = {}
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.name = "activityId"
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.full_name = ".Act240SignInReply.activityId"
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.number = 1
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.index = 0
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.label = 1
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.default_value = 0
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.type = 5
Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.name = "id"
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.full_name = ".Act240SignInReply.id"
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.number = 2
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.index = 1
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.label = 1
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.has_default_value = false
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.default_value = 0
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.type = 5
Activity240Module_pb.ACT240SIGNINREPLYIDFIELD.cpp_type = 1
Activity240Module_pb.ACT240SIGNINREPLY_MSG.name = "Act240SignInReply"
Activity240Module_pb.ACT240SIGNINREPLY_MSG.full_name = ".Act240SignInReply"
Activity240Module_pb.ACT240SIGNINREPLY_MSG.nested_types = {}
Activity240Module_pb.ACT240SIGNINREPLY_MSG.enum_types = {}
Activity240Module_pb.ACT240SIGNINREPLY_MSG.fields = {
	Activity240Module_pb.ACT240SIGNINREPLYACTIVITYIDFIELD,
	Activity240Module_pb.ACT240SIGNINREPLYIDFIELD
}
Activity240Module_pb.ACT240SIGNINREPLY_MSG.is_extendable = false
Activity240Module_pb.ACT240SIGNINREPLY_MSG.extensions = {}
Activity240Module_pb.Act240BackdateReply = protobuf.Message(Activity240Module_pb.ACT240BACKDATEREPLY_MSG)
Activity240Module_pb.Act240BackdateRequest = protobuf.Message(Activity240Module_pb.ACT240BACKDATEREQUEST_MSG)
Activity240Module_pb.Act240GetInfoReply = protobuf.Message(Activity240Module_pb.ACT240GETINFOREPLY_MSG)
Activity240Module_pb.Act240GetInfoRequest = protobuf.Message(Activity240Module_pb.ACT240GETINFOREQUEST_MSG)
Activity240Module_pb.Act240Info = protobuf.Message(Activity240Module_pb.ACT240INFO_MSG)
Activity240Module_pb.Act240SignInReply = protobuf.Message(Activity240Module_pb.ACT240SIGNINREPLY_MSG)
Activity240Module_pb.Act240SignInRequest = protobuf.Message(Activity240Module_pb.ACT240SIGNINREQUEST_MSG)

return Activity240Module_pb

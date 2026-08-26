-- chunkname: @modules/proto/Activity132Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity132Module_pb", package.seeall)

local Activity132Module_pb = {}

Activity132Module_pb.ACT132UNLOCKREPLY_MSG = protobuf.Descriptor()
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.GET132INFOSREPLY_MSG = protobuf.Descriptor()
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG = protobuf.Descriptor()
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG = protobuf.Descriptor()
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.GET132INFOSREQUEST_MSG = protobuf.Descriptor()
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132CONTENT_MSG = protobuf.Descriptor()
Activity132Module_pb.ACT132CONTENTIDFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132CONTENTSTATEFIELD = protobuf.FieldDescriptor()
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.name = "activityId"
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.full_name = ".Act132UnlockReply.activityId"
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.number = 1
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.index = 0
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.label = 1
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.has_default_value = false
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.default_value = 0
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.type = 5
Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD.cpp_type = 1
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.name = "contentId"
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.full_name = ".Act132UnlockReply.contentId"
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.number = 2
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.index = 1
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.label = 3
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.has_default_value = false
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.default_value = {}
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.type = 5
Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD.cpp_type = 1
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.name = "Act132UnlockReply"
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.full_name = ".Act132UnlockReply"
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.nested_types = {}
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.enum_types = {}
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.fields = {
	Activity132Module_pb.ACT132UNLOCKREPLYACTIVITYIDFIELD,
	Activity132Module_pb.ACT132UNLOCKREPLYCONTENTIDFIELD
}
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.is_extendable = false
Activity132Module_pb.ACT132UNLOCKREPLY_MSG.extensions = {}
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.full_name = ".Get132InfosReply.activityId"
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.number = 1
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.index = 0
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.label = 1
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.type = 5
Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.name = "contents"
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.full_name = ".Get132InfosReply.contents"
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.number = 2
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.index = 1
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.label = 3
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.has_default_value = false
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.default_value = {}
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.message_type = Activity132Module_pb.ACT132CONTENT_MSG
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.type = 11
Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD.cpp_type = 10
Activity132Module_pb.GET132INFOSREPLY_MSG.name = "Get132InfosReply"
Activity132Module_pb.GET132INFOSREPLY_MSG.full_name = ".Get132InfosReply"
Activity132Module_pb.GET132INFOSREPLY_MSG.nested_types = {}
Activity132Module_pb.GET132INFOSREPLY_MSG.enum_types = {}
Activity132Module_pb.GET132INFOSREPLY_MSG.fields = {
	Activity132Module_pb.GET132INFOSREPLYACTIVITYIDFIELD,
	Activity132Module_pb.GET132INFOSREPLYCONTENTSFIELD
}
Activity132Module_pb.GET132INFOSREPLY_MSG.is_extendable = false
Activity132Module_pb.GET132INFOSREPLY_MSG.extensions = {}
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.name = "activityId"
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.full_name = ".Act132InfoUpdatePush.activityId"
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.number = 1
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.index = 0
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.label = 1
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.has_default_value = false
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.default_value = 0
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.type = 5
Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.name = "contents"
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.full_name = ".Act132InfoUpdatePush.contents"
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.number = 2
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.index = 1
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.label = 3
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.has_default_value = false
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.default_value = {}
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.message_type = Activity132Module_pb.ACT132CONTENT_MSG
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.type = 11
Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD.cpp_type = 10
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.name = "Act132InfoUpdatePush"
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.full_name = ".Act132InfoUpdatePush"
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.nested_types = {}
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.enum_types = {}
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.fields = {
	Activity132Module_pb.ACT132INFOUPDATEPUSHACTIVITYIDFIELD,
	Activity132Module_pb.ACT132INFOUPDATEPUSHCONTENTSFIELD
}
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.is_extendable = false
Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG.extensions = {}
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.name = "activityId"
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.full_name = ".Act132UnlockRequest.activityId"
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.number = 1
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.index = 0
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.label = 1
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.has_default_value = false
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.default_value = 0
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.type = 5
Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.name = "contentId"
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.full_name = ".Act132UnlockRequest.contentId"
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.number = 2
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.index = 1
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.label = 3
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.has_default_value = false
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.default_value = {}
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.type = 5
Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD.cpp_type = 1
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.name = "Act132UnlockRequest"
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.full_name = ".Act132UnlockRequest"
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.nested_types = {}
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.enum_types = {}
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.fields = {
	Activity132Module_pb.ACT132UNLOCKREQUESTACTIVITYIDFIELD,
	Activity132Module_pb.ACT132UNLOCKREQUESTCONTENTIDFIELD
}
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.is_extendable = false
Activity132Module_pb.ACT132UNLOCKREQUEST_MSG.extensions = {}
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get132InfosRequest.activityId"
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity132Module_pb.GET132INFOSREQUEST_MSG.name = "Get132InfosRequest"
Activity132Module_pb.GET132INFOSREQUEST_MSG.full_name = ".Get132InfosRequest"
Activity132Module_pb.GET132INFOSREQUEST_MSG.nested_types = {}
Activity132Module_pb.GET132INFOSREQUEST_MSG.enum_types = {}
Activity132Module_pb.GET132INFOSREQUEST_MSG.fields = {
	Activity132Module_pb.GET132INFOSREQUESTACTIVITYIDFIELD
}
Activity132Module_pb.GET132INFOSREQUEST_MSG.is_extendable = false
Activity132Module_pb.GET132INFOSREQUEST_MSG.extensions = {}
Activity132Module_pb.ACT132CONTENTIDFIELD.name = "Id"
Activity132Module_pb.ACT132CONTENTIDFIELD.full_name = ".Act132Content.Id"
Activity132Module_pb.ACT132CONTENTIDFIELD.number = 1
Activity132Module_pb.ACT132CONTENTIDFIELD.index = 0
Activity132Module_pb.ACT132CONTENTIDFIELD.label = 1
Activity132Module_pb.ACT132CONTENTIDFIELD.has_default_value = false
Activity132Module_pb.ACT132CONTENTIDFIELD.default_value = 0
Activity132Module_pb.ACT132CONTENTIDFIELD.type = 5
Activity132Module_pb.ACT132CONTENTIDFIELD.cpp_type = 1
Activity132Module_pb.ACT132CONTENTSTATEFIELD.name = "state"
Activity132Module_pb.ACT132CONTENTSTATEFIELD.full_name = ".Act132Content.state"
Activity132Module_pb.ACT132CONTENTSTATEFIELD.number = 2
Activity132Module_pb.ACT132CONTENTSTATEFIELD.index = 1
Activity132Module_pb.ACT132CONTENTSTATEFIELD.label = 1
Activity132Module_pb.ACT132CONTENTSTATEFIELD.has_default_value = false
Activity132Module_pb.ACT132CONTENTSTATEFIELD.default_value = 0
Activity132Module_pb.ACT132CONTENTSTATEFIELD.type = 5
Activity132Module_pb.ACT132CONTENTSTATEFIELD.cpp_type = 1
Activity132Module_pb.ACT132CONTENT_MSG.name = "Act132Content"
Activity132Module_pb.ACT132CONTENT_MSG.full_name = ".Act132Content"
Activity132Module_pb.ACT132CONTENT_MSG.nested_types = {}
Activity132Module_pb.ACT132CONTENT_MSG.enum_types = {}
Activity132Module_pb.ACT132CONTENT_MSG.fields = {
	Activity132Module_pb.ACT132CONTENTIDFIELD,
	Activity132Module_pb.ACT132CONTENTSTATEFIELD
}
Activity132Module_pb.ACT132CONTENT_MSG.is_extendable = false
Activity132Module_pb.ACT132CONTENT_MSG.extensions = {}
Activity132Module_pb.Act132Content = protobuf.Message(Activity132Module_pb.ACT132CONTENT_MSG)
Activity132Module_pb.Act132InfoUpdatePush = protobuf.Message(Activity132Module_pb.ACT132INFOUPDATEPUSH_MSG)
Activity132Module_pb.Act132UnlockReply = protobuf.Message(Activity132Module_pb.ACT132UNLOCKREPLY_MSG)
Activity132Module_pb.Act132UnlockRequest = protobuf.Message(Activity132Module_pb.ACT132UNLOCKREQUEST_MSG)
Activity132Module_pb.Get132InfosReply = protobuf.Message(Activity132Module_pb.GET132INFOSREPLY_MSG)
Activity132Module_pb.Get132InfosRequest = protobuf.Message(Activity132Module_pb.GET132INFOSREQUEST_MSG)

return Activity132Module_pb

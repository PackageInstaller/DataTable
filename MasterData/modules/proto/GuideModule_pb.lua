-- chunkname: @modules/proto/GuideModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.GuideModule_pb", package.seeall)

local GuideModule_pb = {}

GuideModule_pb.GETGUIDEINFOREPLY_MSG = protobuf.Descriptor()
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD = protobuf.FieldDescriptor()
GuideModule_pb.GUIDEINFO_MSG = protobuf.Descriptor()
GuideModule_pb.GUIDEINFOGUIDEIDFIELD = protobuf.FieldDescriptor()
GuideModule_pb.GUIDEINFOSTEPIDFIELD = protobuf.FieldDescriptor()
GuideModule_pb.UPDATEGUIDEPUSH_MSG = protobuf.Descriptor()
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD = protobuf.FieldDescriptor()
GuideModule_pb.FINISHGUIDEREPLY_MSG = protobuf.Descriptor()
GuideModule_pb.FINISHGUIDEREQUEST_MSG = protobuf.Descriptor()
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD = protobuf.FieldDescriptor()
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD = protobuf.FieldDescriptor()
GuideModule_pb.GETGUIDEINFOREQUEST_MSG = protobuf.Descriptor()
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.name = "guideInfos"
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.full_name = ".GetGuideInfoReply.guideInfos"
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.number = 1
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.index = 0
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.label = 3
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.has_default_value = false
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.default_value = {}
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.message_type = GuideModule_pb.GUIDEINFO_MSG
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.type = 11
GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD.cpp_type = 10
GuideModule_pb.GETGUIDEINFOREPLY_MSG.name = "GetGuideInfoReply"
GuideModule_pb.GETGUIDEINFOREPLY_MSG.full_name = ".GetGuideInfoReply"
GuideModule_pb.GETGUIDEINFOREPLY_MSG.nested_types = {}
GuideModule_pb.GETGUIDEINFOREPLY_MSG.enum_types = {}
GuideModule_pb.GETGUIDEINFOREPLY_MSG.fields = {
	GuideModule_pb.GETGUIDEINFOREPLYGUIDEINFOSFIELD
}
GuideModule_pb.GETGUIDEINFOREPLY_MSG.is_extendable = false
GuideModule_pb.GETGUIDEINFOREPLY_MSG.extensions = {}
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.name = "guideId"
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.full_name = ".GuideInfo.guideId"
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.number = 1
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.index = 0
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.label = 2
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.has_default_value = false
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.default_value = 0
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.type = 5
GuideModule_pb.GUIDEINFOGUIDEIDFIELD.cpp_type = 1
GuideModule_pb.GUIDEINFOSTEPIDFIELD.name = "stepId"
GuideModule_pb.GUIDEINFOSTEPIDFIELD.full_name = ".GuideInfo.stepId"
GuideModule_pb.GUIDEINFOSTEPIDFIELD.number = 2
GuideModule_pb.GUIDEINFOSTEPIDFIELD.index = 1
GuideModule_pb.GUIDEINFOSTEPIDFIELD.label = 2
GuideModule_pb.GUIDEINFOSTEPIDFIELD.has_default_value = false
GuideModule_pb.GUIDEINFOSTEPIDFIELD.default_value = 0
GuideModule_pb.GUIDEINFOSTEPIDFIELD.type = 5
GuideModule_pb.GUIDEINFOSTEPIDFIELD.cpp_type = 1
GuideModule_pb.GUIDEINFO_MSG.name = "GuideInfo"
GuideModule_pb.GUIDEINFO_MSG.full_name = ".GuideInfo"
GuideModule_pb.GUIDEINFO_MSG.nested_types = {}
GuideModule_pb.GUIDEINFO_MSG.enum_types = {}
GuideModule_pb.GUIDEINFO_MSG.fields = {
	GuideModule_pb.GUIDEINFOGUIDEIDFIELD,
	GuideModule_pb.GUIDEINFOSTEPIDFIELD
}
GuideModule_pb.GUIDEINFO_MSG.is_extendable = false
GuideModule_pb.GUIDEINFO_MSG.extensions = {}
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.name = "guideInfos"
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.full_name = ".UpdateGuidePush.guideInfos"
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.number = 1
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.index = 0
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.label = 3
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.has_default_value = false
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.default_value = {}
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.message_type = GuideModule_pb.GUIDEINFO_MSG
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.type = 11
GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD.cpp_type = 10
GuideModule_pb.UPDATEGUIDEPUSH_MSG.name = "UpdateGuidePush"
GuideModule_pb.UPDATEGUIDEPUSH_MSG.full_name = ".UpdateGuidePush"
GuideModule_pb.UPDATEGUIDEPUSH_MSG.nested_types = {}
GuideModule_pb.UPDATEGUIDEPUSH_MSG.enum_types = {}
GuideModule_pb.UPDATEGUIDEPUSH_MSG.fields = {
	GuideModule_pb.UPDATEGUIDEPUSHGUIDEINFOSFIELD
}
GuideModule_pb.UPDATEGUIDEPUSH_MSG.is_extendable = false
GuideModule_pb.UPDATEGUIDEPUSH_MSG.extensions = {}
GuideModule_pb.FINISHGUIDEREPLY_MSG.name = "FinishGuideReply"
GuideModule_pb.FINISHGUIDEREPLY_MSG.full_name = ".FinishGuideReply"
GuideModule_pb.FINISHGUIDEREPLY_MSG.nested_types = {}
GuideModule_pb.FINISHGUIDEREPLY_MSG.enum_types = {}
GuideModule_pb.FINISHGUIDEREPLY_MSG.fields = {}
GuideModule_pb.FINISHGUIDEREPLY_MSG.is_extendable = false
GuideModule_pb.FINISHGUIDEREPLY_MSG.extensions = {}
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.name = "guideId"
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.full_name = ".FinishGuideRequest.guideId"
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.number = 1
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.index = 0
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.label = 2
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.has_default_value = false
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.default_value = 0
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.type = 5
GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD.cpp_type = 1
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.name = "stepId"
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.full_name = ".FinishGuideRequest.stepId"
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.number = 2
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.index = 1
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.label = 2
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.has_default_value = false
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.default_value = 0
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.type = 5
GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD.cpp_type = 1
GuideModule_pb.FINISHGUIDEREQUEST_MSG.name = "FinishGuideRequest"
GuideModule_pb.FINISHGUIDEREQUEST_MSG.full_name = ".FinishGuideRequest"
GuideModule_pb.FINISHGUIDEREQUEST_MSG.nested_types = {}
GuideModule_pb.FINISHGUIDEREQUEST_MSG.enum_types = {}
GuideModule_pb.FINISHGUIDEREQUEST_MSG.fields = {
	GuideModule_pb.FINISHGUIDEREQUESTGUIDEIDFIELD,
	GuideModule_pb.FINISHGUIDEREQUESTSTEPIDFIELD
}
GuideModule_pb.FINISHGUIDEREQUEST_MSG.is_extendable = false
GuideModule_pb.FINISHGUIDEREQUEST_MSG.extensions = {}
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.name = "GetGuideInfoRequest"
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.full_name = ".GetGuideInfoRequest"
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.nested_types = {}
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.enum_types = {}
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.fields = {}
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.is_extendable = false
GuideModule_pb.GETGUIDEINFOREQUEST_MSG.extensions = {}
GuideModule_pb.FinishGuideReply = protobuf.Message(GuideModule_pb.FINISHGUIDEREPLY_MSG)
GuideModule_pb.FinishGuideRequest = protobuf.Message(GuideModule_pb.FINISHGUIDEREQUEST_MSG)
GuideModule_pb.GetGuideInfoReply = protobuf.Message(GuideModule_pb.GETGUIDEINFOREPLY_MSG)
GuideModule_pb.GetGuideInfoRequest = protobuf.Message(GuideModule_pb.GETGUIDEINFOREQUEST_MSG)
GuideModule_pb.GuideInfo = protobuf.Message(GuideModule_pb.GUIDEINFO_MSG)
GuideModule_pb.UpdateGuidePush = protobuf.Message(GuideModule_pb.UPDATEGUIDEPUSH_MSG)

return GuideModule_pb

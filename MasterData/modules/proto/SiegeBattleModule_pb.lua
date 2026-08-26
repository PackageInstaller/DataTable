-- chunkname: @modules/proto/SiegeBattleModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.SiegeBattleModule_pb", package.seeall)

local SiegeBattleModule_pb = {}

SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD = protobuf.FieldDescriptor()
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD = protobuf.FieldDescriptor()
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD = protobuf.FieldDescriptor()
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD = protobuf.FieldDescriptor()
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD = protobuf.FieldDescriptor()
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG = protobuf.Descriptor()
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.name = "info"
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.full_name = ".GetSiegeBattleInfoReply.info"
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.number = 1
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.index = 0
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.label = 1
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.has_default_value = false
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.default_value = nil
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.message_type = SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.type = 11
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD.cpp_type = 10
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.name = "GetSiegeBattleInfoReply"
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.full_name = ".GetSiegeBattleInfoReply"
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.nested_types = {}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.enum_types = {}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.fields = {
	SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLYINFOFIELD
}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.is_extendable = false
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG.extensions = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.name = "info"
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.full_name = ".StartSiegeBattleReply.info"
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.number = 1
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.index = 0
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.label = 1
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.has_default_value = false
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.default_value = nil
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.message_type = SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.type = 11
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD.cpp_type = 10
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.name = "StartSiegeBattleReply"
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.full_name = ".StartSiegeBattleReply"
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.nested_types = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.enum_types = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.fields = {
	SiegeBattleModule_pb.STARTSIEGEBATTLEREPLYINFOFIELD
}
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.is_extendable = false
SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG.extensions = {}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.name = "GetSiegeBattleInfoRequest"
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.full_name = ".GetSiegeBattleInfoRequest"
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.nested_types = {}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.enum_types = {}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.fields = {}
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.is_extendable = false
SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG.extensions = {}
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.name = "openChallenge"
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.full_name = ".SiegeBattleInfo.openChallenge"
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.number = 1
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.index = 0
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.label = 1
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.has_default_value = false
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.default_value = false
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.type = 8
SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD.cpp_type = 7
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.name = "passChallengeIds"
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.full_name = ".SiegeBattleInfo.passChallengeIds"
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.number = 2
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.index = 1
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.label = 3
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.has_default_value = false
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.default_value = {}
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.type = 5
SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD.cpp_type = 1
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.name = "SiegeBattleInfo"
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.full_name = ".SiegeBattleInfo"
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.nested_types = {}
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.enum_types = {}
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.fields = {
	SiegeBattleModule_pb.SIEGEBATTLEINFOOPENCHALLENGEFIELD,
	SiegeBattleModule_pb.SIEGEBATTLEINFOPASSCHALLENGEIDSFIELD
}
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.is_extendable = false
SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG.extensions = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.name = "info"
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.full_name = ".AbandonSiegeBattleReply.info"
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.number = 1
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.index = 0
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.label = 1
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.has_default_value = false
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.default_value = nil
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.message_type = SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.type = 11
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD.cpp_type = 10
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.name = "AbandonSiegeBattleReply"
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.full_name = ".AbandonSiegeBattleReply"
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.nested_types = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.enum_types = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.fields = {
	SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLYINFOFIELD
}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.is_extendable = false
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG.extensions = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.name = "AbandonSiegeBattleRequest"
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.full_name = ".AbandonSiegeBattleRequest"
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.nested_types = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.enum_types = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.fields = {}
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.is_extendable = false
SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG.extensions = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.name = "StartSiegeBattleRequest"
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.full_name = ".StartSiegeBattleRequest"
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.nested_types = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.enum_types = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.fields = {}
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.is_extendable = false
SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG.extensions = {}
SiegeBattleModule_pb.AbandonSiegeBattleReply = protobuf.Message(SiegeBattleModule_pb.ABANDONSIEGEBATTLEREPLY_MSG)
SiegeBattleModule_pb.AbandonSiegeBattleRequest = protobuf.Message(SiegeBattleModule_pb.ABANDONSIEGEBATTLEREQUEST_MSG)
SiegeBattleModule_pb.GetSiegeBattleInfoReply = protobuf.Message(SiegeBattleModule_pb.GETSIEGEBATTLEINFOREPLY_MSG)
SiegeBattleModule_pb.GetSiegeBattleInfoRequest = protobuf.Message(SiegeBattleModule_pb.GETSIEGEBATTLEINFOREQUEST_MSG)
SiegeBattleModule_pb.SiegeBattleInfo = protobuf.Message(SiegeBattleModule_pb.SIEGEBATTLEINFO_MSG)
SiegeBattleModule_pb.StartSiegeBattleReply = protobuf.Message(SiegeBattleModule_pb.STARTSIEGEBATTLEREPLY_MSG)
SiegeBattleModule_pb.StartSiegeBattleRequest = protobuf.Message(SiegeBattleModule_pb.STARTSIEGEBATTLEREQUEST_MSG)

return SiegeBattleModule_pb

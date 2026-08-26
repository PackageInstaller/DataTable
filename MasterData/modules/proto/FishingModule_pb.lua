-- chunkname: @modules/proto/FishingModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.FishingModule_pb", package.seeall)

local FishingModule_pb = {}

FishingModule_pb.MATERIALMODULE_PB = require("modules.proto.MaterialModule_pb")
FishingModule_pb.FISHINGREQUEST_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPOOLINFO_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG = protobuf.Descriptor()
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG = protobuf.Descriptor()
FishingModule_pb.GETFISHINGINFOREQUEST_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGPROGRESSINFO_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG = protobuf.Descriptor()
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGREPLY_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGREPLYPROGRESSFIELD = protobuf.FieldDescriptor()
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG = protobuf.Descriptor()
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD = protobuf.FieldDescriptor()
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGFRIENDINFO_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGBOATINFO_MSG = protobuf.Descriptor()
FishingModule_pb.FISHINGBOATINFOTYPEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGBOATINFONAMEFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETFISHINGINFOREPLY_MSG = protobuf.Descriptor()
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG = protobuf.Descriptor()
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG = protobuf.Descriptor()
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG = protobuf.Descriptor()
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETFISHINGBONUSREPLY_MSG = protobuf.Descriptor()
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD = protobuf.FieldDescriptor()
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD = protobuf.FieldDescriptor()
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.name = "poolUserId"
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.full_name = ".FishingRequest.poolUserId"
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.number = 1
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.index = 0
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.label = 1
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.has_default_value = false
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.default_value = 0
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.type = 4
FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD.cpp_type = 4
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.name = "fishTimes"
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.full_name = ".FishingRequest.fishTimes"
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.number = 2
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.index = 1
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.label = 1
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.has_default_value = false
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.default_value = 0
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.type = 5
FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD.cpp_type = 1
FishingModule_pb.FISHINGREQUEST_MSG.name = "FishingRequest"
FishingModule_pb.FISHINGREQUEST_MSG.full_name = ".FishingRequest"
FishingModule_pb.FISHINGREQUEST_MSG.nested_types = {}
FishingModule_pb.FISHINGREQUEST_MSG.enum_types = {}
FishingModule_pb.FISHINGREQUEST_MSG.fields = {
	FishingModule_pb.FISHINGREQUESTPOOLUSERIDFIELD,
	FishingModule_pb.FISHINGREQUESTFISHTIMESFIELD
}
FishingModule_pb.FISHINGREQUEST_MSG.is_extendable = false
FishingModule_pb.FISHINGREQUEST_MSG.extensions = {}
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.name = "poolId"
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.full_name = ".FishingPoolInfo.poolId"
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.number = 1
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.index = 0
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.label = 1
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.has_default_value = false
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.default_value = 0
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.type = 5
FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD.cpp_type = 1
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.name = "refreshTime"
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.full_name = ".FishingPoolInfo.refreshTime"
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.number = 2
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.index = 1
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.label = 1
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.has_default_value = false
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.default_value = 0
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.type = 5
FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD.cpp_type = 1
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.name = "boatsInfo"
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.full_name = ".FishingPoolInfo.boatsInfo"
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.number = 3
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.index = 2
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.label = 3
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.has_default_value = false
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.default_value = {}
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.message_type = FishingModule_pb.FISHINGBOATINFO_MSG
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.type = 11
FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD.cpp_type = 10
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.name = "fishingProgress"
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.full_name = ".FishingPoolInfo.fishingProgress"
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.number = 4
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.index = 3
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.label = 3
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.has_default_value = false
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.default_value = {}
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.message_type = FishingModule_pb.FISHINGPROGRESSINFO_MSG
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.type = 11
FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD.cpp_type = 10
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.name = "changeCount"
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.full_name = ".FishingPoolInfo.changeCount"
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.number = 5
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.index = 4
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.label = 1
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.has_default_value = false
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.default_value = 0
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.type = 5
FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD.cpp_type = 1
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.name = "todayAcceptShareCount"
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.full_name = ".FishingPoolInfo.todayAcceptShareCount"
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.number = 6
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.index = 5
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.label = 1
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.has_default_value = false
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.default_value = 0
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.type = 5
FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD.cpp_type = 1
FishingModule_pb.FISHINGPOOLINFO_MSG.name = "FishingPoolInfo"
FishingModule_pb.FISHINGPOOLINFO_MSG.full_name = ".FishingPoolInfo"
FishingModule_pb.FISHINGPOOLINFO_MSG.nested_types = {}
FishingModule_pb.FISHINGPOOLINFO_MSG.enum_types = {}
FishingModule_pb.FISHINGPOOLINFO_MSG.fields = {
	FishingModule_pb.FISHINGPOOLINFOPOOLIDFIELD,
	FishingModule_pb.FISHINGPOOLINFOREFRESHTIMEFIELD,
	FishingModule_pb.FISHINGPOOLINFOBOATSINFOFIELD,
	FishingModule_pb.FISHINGPOOLINFOFISHINGPROGRESSFIELD,
	FishingModule_pb.FISHINGPOOLINFOCHANGECOUNTFIELD,
	FishingModule_pb.FISHINGPOOLINFOTODAYACCEPTSHARECOUNTFIELD
}
FishingModule_pb.FISHINGPOOLINFO_MSG.is_extendable = false
FishingModule_pb.FISHINGPOOLINFO_MSG.extensions = {}
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.name = "notFishingFriendInfo"
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.full_name = ".GetFishingFriendsReply.notFishingFriendInfo"
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.number = 1
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.index = 0
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.label = 3
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.has_default_value = false
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.default_value = {}
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.message_type = FishingModule_pb.FISHINGFRIENDINFO_MSG
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.type = 11
FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD.cpp_type = 10
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.name = "GetFishingFriendsReply"
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.full_name = ".GetFishingFriendsReply"
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.nested_types = {}
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.enum_types = {}
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.fields = {
	FishingModule_pb.GETFISHINGFRIENDSREPLYNOTFISHINGFRIENDINFOFIELD
}
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.is_extendable = false
FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG.extensions = {}
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.name = "GetFishingFriendsRequest"
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.full_name = ".GetFishingFriendsRequest"
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.nested_types = {}
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.enum_types = {}
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.fields = {}
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.is_extendable = false
FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG.extensions = {}
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.name = "GetFishingInfoRequest"
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.full_name = ".GetFishingInfoRequest"
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.nested_types = {}
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.enum_types = {}
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.fields = {}
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.is_extendable = false
FishingModule_pb.GETFISHINGINFOREQUEST_MSG.extensions = {}
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.name = "type"
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.full_name = ".FishingProgressInfo.type"
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.number = 1
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.index = 0
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.type = 5
FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD.cpp_type = 1
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.name = "fisheryUserId"
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.full_name = ".FishingProgressInfo.fisheryUserId"
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.number = 2
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.index = 1
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.type = 4
FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD.cpp_type = 4
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.name = "poolId"
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.full_name = ".FishingProgressInfo.poolId"
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.number = 3
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.index = 2
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.type = 5
FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD.cpp_type = 1
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.name = "fishTimes"
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.full_name = ".FishingProgressInfo.fishTimes"
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.number = 4
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.index = 3
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.type = 5
FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD.cpp_type = 1
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.name = "startTime"
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.full_name = ".FishingProgressInfo.startTime"
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.number = 5
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.index = 4
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.type = 5
FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD.cpp_type = 1
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.name = "finishTime"
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.full_name = ".FishingProgressInfo.finishTime"
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.number = 6
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.index = 5
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.type = 5
FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD.cpp_type = 1
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.name = "name"
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.full_name = ".FishingProgressInfo.name"
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.number = 7
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.index = 6
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.default_value = ""
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.type = 9
FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD.cpp_type = 9
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.name = "portrait"
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.full_name = ".FishingProgressInfo.portrait"
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.number = 8
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.index = 7
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.label = 1
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.has_default_value = false
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.default_value = 0
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.type = 13
FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD.cpp_type = 3
FishingModule_pb.FISHINGPROGRESSINFO_MSG.name = "FishingProgressInfo"
FishingModule_pb.FISHINGPROGRESSINFO_MSG.full_name = ".FishingProgressInfo"
FishingModule_pb.FISHINGPROGRESSINFO_MSG.nested_types = {}
FishingModule_pb.FISHINGPROGRESSINFO_MSG.enum_types = {}
FishingModule_pb.FISHINGPROGRESSINFO_MSG.fields = {
	FishingModule_pb.FISHINGPROGRESSINFOTYPEFIELD,
	FishingModule_pb.FISHINGPROGRESSINFOFISHERYUSERIDFIELD,
	FishingModule_pb.FISHINGPROGRESSINFOPOOLIDFIELD,
	FishingModule_pb.FISHINGPROGRESSINFOFISHTIMESFIELD,
	FishingModule_pb.FISHINGPROGRESSINFOSTARTTIMEFIELD,
	FishingModule_pb.FISHINGPROGRESSINFOFINISHTIMEFIELD,
	FishingModule_pb.FISHINGPROGRESSINFONAMEFIELD,
	FishingModule_pb.FISHINGPROGRESSINFOPORTRAITFIELD
}
FishingModule_pb.FISHINGPROGRESSINFO_MSG.is_extendable = false
FishingModule_pb.FISHINGPROGRESSINFO_MSG.extensions = {}
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.name = "userId"
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.full_name = ".GetOtherFishingInfoRequest.userId"
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.number = 1
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.index = 0
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.label = 1
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.has_default_value = false
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.default_value = 0
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.type = 4
FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD.cpp_type = 4
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.name = "GetOtherFishingInfoRequest"
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.full_name = ".GetOtherFishingInfoRequest"
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.nested_types = {}
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.enum_types = {}
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.fields = {
	FishingModule_pb.GETOTHERFISHINGINFOREQUESTUSERIDFIELD
}
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.is_extendable = false
FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG.extensions = {}
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.name = "poolUserId"
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.full_name = ".FishingReply.poolUserId"
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.number = 1
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.index = 0
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.label = 1
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.has_default_value = false
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.default_value = 0
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.type = 4
FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD.cpp_type = 4
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.name = "fishTimes"
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.full_name = ".FishingReply.fishTimes"
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.number = 2
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.index = 1
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.label = 1
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.has_default_value = false
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.default_value = 0
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.type = 5
FishingModule_pb.FISHINGREPLYFISHTIMESFIELD.cpp_type = 1
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.name = "progress"
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.full_name = ".FishingReply.progress"
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.number = 3
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.index = 2
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.label = 1
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.has_default_value = false
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.default_value = nil
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.message_type = FishingModule_pb.FISHINGPROGRESSINFO_MSG
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.type = 11
FishingModule_pb.FISHINGREPLYPROGRESSFIELD.cpp_type = 10
FishingModule_pb.FISHINGREPLY_MSG.name = "FishingReply"
FishingModule_pb.FISHINGREPLY_MSG.full_name = ".FishingReply"
FishingModule_pb.FISHINGREPLY_MSG.nested_types = {}
FishingModule_pb.FISHINGREPLY_MSG.enum_types = {}
FishingModule_pb.FISHINGREPLY_MSG.fields = {
	FishingModule_pb.FISHINGREPLYPOOLUSERIDFIELD,
	FishingModule_pb.FISHINGREPLYFISHTIMESFIELD,
	FishingModule_pb.FISHINGREPLYPROGRESSFIELD
}
FishingModule_pb.FISHINGREPLY_MSG.is_extendable = false
FishingModule_pb.FISHINGREPLY_MSG.extensions = {}
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.name = "count"
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.full_name = ".ChangeFishingCurrencyReply.count"
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.number = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.index = 0
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.label = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.has_default_value = false
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.default_value = 0
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.type = 5
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD.cpp_type = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.name = "exchangedCount"
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.full_name = ".ChangeFishingCurrencyReply.exchangedCount"
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.number = 2
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.index = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.label = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.has_default_value = false
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.default_value = 0
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.type = 5
FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD.cpp_type = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.name = "ChangeFishingCurrencyReply"
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.full_name = ".ChangeFishingCurrencyReply"
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.nested_types = {}
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.enum_types = {}
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.fields = {
	FishingModule_pb.CHANGEFISHINGCURRENCYREPLYCOUNTFIELD,
	FishingModule_pb.CHANGEFISHINGCURRENCYREPLYEXCHANGEDCOUNTFIELD
}
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.is_extendable = false
FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG.extensions = {}
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.name = "type"
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.full_name = ".FishingFriendInfo.type"
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.number = 1
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.index = 0
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.label = 1
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.has_default_value = false
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.default_value = 0
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.type = 5
FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD.cpp_type = 1
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.name = "userId"
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.full_name = ".FishingFriendInfo.userId"
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.number = 2
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.index = 1
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.label = 1
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.has_default_value = false
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.default_value = 0
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.type = 4
FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD.cpp_type = 4
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.name = "name"
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.full_name = ".FishingFriendInfo.name"
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.number = 3
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.index = 2
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.label = 1
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.has_default_value = false
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.default_value = ""
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.type = 9
FishingModule_pb.FISHINGFRIENDINFONAMEFIELD.cpp_type = 9
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.name = "portrait"
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.full_name = ".FishingFriendInfo.portrait"
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.number = 4
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.index = 3
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.label = 1
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.has_default_value = false
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.default_value = 0
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.type = 13
FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD.cpp_type = 3
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.name = "poolId"
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.full_name = ".FishingFriendInfo.poolId"
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.number = 5
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.index = 4
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.label = 1
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.has_default_value = false
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.default_value = 0
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.type = 5
FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD.cpp_type = 1
FishingModule_pb.FISHINGFRIENDINFO_MSG.name = "FishingFriendInfo"
FishingModule_pb.FISHINGFRIENDINFO_MSG.full_name = ".FishingFriendInfo"
FishingModule_pb.FISHINGFRIENDINFO_MSG.nested_types = {}
FishingModule_pb.FISHINGFRIENDINFO_MSG.enum_types = {}
FishingModule_pb.FISHINGFRIENDINFO_MSG.fields = {
	FishingModule_pb.FISHINGFRIENDINFOTYPEFIELD,
	FishingModule_pb.FISHINGFRIENDINFOUSERIDFIELD,
	FishingModule_pb.FISHINGFRIENDINFONAMEFIELD,
	FishingModule_pb.FISHINGFRIENDINFOPORTRAITFIELD,
	FishingModule_pb.FISHINGFRIENDINFOPOOLIDFIELD
}
FishingModule_pb.FISHINGFRIENDINFO_MSG.is_extendable = false
FishingModule_pb.FISHINGFRIENDINFO_MSG.extensions = {}
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.name = "type"
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.full_name = ".FishingBoatInfo.type"
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.number = 1
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.index = 0
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.label = 1
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.has_default_value = false
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.default_value = 0
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.type = 5
FishingModule_pb.FISHINGBOATINFOTYPEFIELD.cpp_type = 1
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.name = "userId"
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.full_name = ".FishingBoatInfo.userId"
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.number = 2
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.index = 1
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.label = 1
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.has_default_value = false
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.default_value = 0
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.type = 4
FishingModule_pb.FISHINGBOATINFOUSERIDFIELD.cpp_type = 4
FishingModule_pb.FISHINGBOATINFONAMEFIELD.name = "name"
FishingModule_pb.FISHINGBOATINFONAMEFIELD.full_name = ".FishingBoatInfo.name"
FishingModule_pb.FISHINGBOATINFONAMEFIELD.number = 3
FishingModule_pb.FISHINGBOATINFONAMEFIELD.index = 2
FishingModule_pb.FISHINGBOATINFONAMEFIELD.label = 1
FishingModule_pb.FISHINGBOATINFONAMEFIELD.has_default_value = false
FishingModule_pb.FISHINGBOATINFONAMEFIELD.default_value = ""
FishingModule_pb.FISHINGBOATINFONAMEFIELD.type = 9
FishingModule_pb.FISHINGBOATINFONAMEFIELD.cpp_type = 9
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.name = "portrait"
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.full_name = ".FishingBoatInfo.portrait"
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.number = 4
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.index = 3
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.label = 1
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.has_default_value = false
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.default_value = 0
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.type = 13
FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD.cpp_type = 3
FishingModule_pb.FISHINGBOATINFO_MSG.name = "FishingBoatInfo"
FishingModule_pb.FISHINGBOATINFO_MSG.full_name = ".FishingBoatInfo"
FishingModule_pb.FISHINGBOATINFO_MSG.nested_types = {}
FishingModule_pb.FISHINGBOATINFO_MSG.enum_types = {}
FishingModule_pb.FISHINGBOATINFO_MSG.fields = {
	FishingModule_pb.FISHINGBOATINFOTYPEFIELD,
	FishingModule_pb.FISHINGBOATINFOUSERIDFIELD,
	FishingModule_pb.FISHINGBOATINFONAMEFIELD,
	FishingModule_pb.FISHINGBOATINFOPORTRAITFIELD
}
FishingModule_pb.FISHINGBOATINFO_MSG.is_extendable = false
FishingModule_pb.FISHINGBOATINFO_MSG.extensions = {}
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.name = "fishingPoolInfo"
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.full_name = ".GetFishingInfoReply.fishingPoolInfo"
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.number = 1
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.index = 0
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.label = 1
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.has_default_value = false
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.default_value = nil
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.message_type = FishingModule_pb.FISHINGPOOLINFO_MSG
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.type = 11
FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD.cpp_type = 10
FishingModule_pb.GETFISHINGINFOREPLY_MSG.name = "GetFishingInfoReply"
FishingModule_pb.GETFISHINGINFOREPLY_MSG.full_name = ".GetFishingInfoReply"
FishingModule_pb.GETFISHINGINFOREPLY_MSG.nested_types = {}
FishingModule_pb.GETFISHINGINFOREPLY_MSG.enum_types = {}
FishingModule_pb.GETFISHINGINFOREPLY_MSG.fields = {
	FishingModule_pb.GETFISHINGINFOREPLYFISHINGPOOLINFOFIELD
}
FishingModule_pb.GETFISHINGINFOREPLY_MSG.is_extendable = false
FishingModule_pb.GETFISHINGINFOREPLY_MSG.extensions = {}
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.name = "userId"
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.full_name = ".GetOtherFishingInfoReply.userId"
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.number = 1
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.index = 0
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.label = 1
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.has_default_value = false
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.default_value = 0
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.type = 4
FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD.cpp_type = 4
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.name = "fishingPoolInfo"
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.full_name = ".GetOtherFishingInfoReply.fishingPoolInfo"
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.number = 2
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.index = 1
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.label = 1
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.has_default_value = false
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.default_value = nil
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.message_type = FishingModule_pb.FISHINGPOOLINFO_MSG
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.type = 11
FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD.cpp_type = 10
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.name = "friendInfo"
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.full_name = ".GetOtherFishingInfoReply.friendInfo"
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.number = 3
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.index = 2
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.label = 1
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.has_default_value = false
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.default_value = nil
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.message_type = FishingModule_pb.FISHINGFRIENDINFO_MSG
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.type = 11
FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD.cpp_type = 10
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.name = "GetOtherFishingInfoReply"
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.full_name = ".GetOtherFishingInfoReply"
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.nested_types = {}
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.enum_types = {}
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.fields = {
	FishingModule_pb.GETOTHERFISHINGINFOREPLYUSERIDFIELD,
	FishingModule_pb.GETOTHERFISHINGINFOREPLYFISHINGPOOLINFOFIELD,
	FishingModule_pb.GETOTHERFISHINGINFOREPLYFRIENDINFOFIELD
}
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.is_extendable = false
FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG.extensions = {}
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.name = "GetFishingBonusRequest"
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.full_name = ".GetFishingBonusRequest"
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.nested_types = {}
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.enum_types = {}
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.fields = {}
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.is_extendable = false
FishingModule_pb.GETFISHINGBONUSREQUEST_MSG.extensions = {}
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.name = "count"
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.full_name = ".ChangeFishingCurrencyRequest.count"
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.number = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.index = 0
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.label = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.has_default_value = false
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.default_value = 0
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.type = 5
FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD.cpp_type = 1
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.name = "ChangeFishingCurrencyRequest"
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.full_name = ".ChangeFishingCurrencyRequest"
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.nested_types = {}
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.enum_types = {}
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.fields = {
	FishingModule_pb.CHANGEFISHINGCURRENCYREQUESTCOUNTFIELD
}
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.is_extendable = false
FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG.extensions = {}
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.name = "bonusInfo"
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.full_name = ".GetFishingBonusReply.bonusInfo"
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.number = 1
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.index = 0
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.label = 3
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.has_default_value = false
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.default_value = {}
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.message_type = FishingModule_pb.FISHINGPROGRESSINFO_MSG
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.type = 11
FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD.cpp_type = 10
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.name = "todayAcceptShareCount"
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.full_name = ".GetFishingBonusReply.todayAcceptShareCount"
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.number = 2
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.index = 1
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.label = 1
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.has_default_value = false
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.default_value = 0
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.type = 5
FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD.cpp_type = 1
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.name = "GetFishingBonusReply"
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.full_name = ".GetFishingBonusReply"
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.nested_types = {}
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.enum_types = {}
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.fields = {
	FishingModule_pb.GETFISHINGBONUSREPLYBONUSINFOFIELD,
	FishingModule_pb.GETFISHINGBONUSREPLYTODAYACCEPTSHARECOUNTFIELD
}
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.is_extendable = false
FishingModule_pb.GETFISHINGBONUSREPLY_MSG.extensions = {}
FishingModule_pb.ChangeFishingCurrencyReply = protobuf.Message(FishingModule_pb.CHANGEFISHINGCURRENCYREPLY_MSG)
FishingModule_pb.ChangeFishingCurrencyRequest = protobuf.Message(FishingModule_pb.CHANGEFISHINGCURRENCYREQUEST_MSG)
FishingModule_pb.FishingBoatInfo = protobuf.Message(FishingModule_pb.FISHINGBOATINFO_MSG)
FishingModule_pb.FishingFriendInfo = protobuf.Message(FishingModule_pb.FISHINGFRIENDINFO_MSG)
FishingModule_pb.FishingPoolInfo = protobuf.Message(FishingModule_pb.FISHINGPOOLINFO_MSG)
FishingModule_pb.FishingProgressInfo = protobuf.Message(FishingModule_pb.FISHINGPROGRESSINFO_MSG)
FishingModule_pb.FishingReply = protobuf.Message(FishingModule_pb.FISHINGREPLY_MSG)
FishingModule_pb.FishingRequest = protobuf.Message(FishingModule_pb.FISHINGREQUEST_MSG)
FishingModule_pb.GetFishingBonusReply = protobuf.Message(FishingModule_pb.GETFISHINGBONUSREPLY_MSG)
FishingModule_pb.GetFishingBonusRequest = protobuf.Message(FishingModule_pb.GETFISHINGBONUSREQUEST_MSG)
FishingModule_pb.GetFishingFriendsReply = protobuf.Message(FishingModule_pb.GETFISHINGFRIENDSREPLY_MSG)
FishingModule_pb.GetFishingFriendsRequest = protobuf.Message(FishingModule_pb.GETFISHINGFRIENDSREQUEST_MSG)
FishingModule_pb.GetFishingInfoReply = protobuf.Message(FishingModule_pb.GETFISHINGINFOREPLY_MSG)
FishingModule_pb.GetFishingInfoRequest = protobuf.Message(FishingModule_pb.GETFISHINGINFOREQUEST_MSG)
FishingModule_pb.GetOtherFishingInfoReply = protobuf.Message(FishingModule_pb.GETOTHERFISHINGINFOREPLY_MSG)
FishingModule_pb.GetOtherFishingInfoRequest = protobuf.Message(FishingModule_pb.GETOTHERFISHINGINFOREQUEST_MSG)

return FishingModule_pb

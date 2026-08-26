-- chunkname: @modules/proto/ChargeModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.ChargeModule_pb", package.seeall)

local ChargeModule_pb = {}

ChargeModule_pb.GETCHARGEINFOREQUEST_MSG = protobuf.Descriptor()
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG = protobuf.Descriptor()
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.GETCHARGEINFOREPLY_MSG = protobuf.Descriptor()
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLY_MSG = protobuf.Descriptor()
ChargeModule_pb.NEWORDERREPLYIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLYSIGNFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG = protobuf.Descriptor()
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREQUEST_MSG = protobuf.Descriptor()
ChargeModule_pb.NEWORDERREQUESTIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG = protobuf.Descriptor()
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.CHARGEINFO_MSG = protobuf.Descriptor()
ChargeModule_pb.CHARGEINFOIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG = protobuf.Descriptor()
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.READCHARGENEWREQUEST_MSG = protobuf.Descriptor()
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.SELECTIONINFO_MSG = protobuf.Descriptor()
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG = protobuf.Descriptor()
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG = protobuf.Descriptor()
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.READCHARGENEWREPLY_MSG = protobuf.Descriptor()
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.MONTHCARDINFO_MSG = protobuf.Descriptor()
ChargeModule_pb.MONTHCARDINFOIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG = protobuf.Descriptor()
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.name = "GetChargeInfoRequest"
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.full_name = ".GetChargeInfoRequest"
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.nested_types = {}
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.enum_types = {}
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.fields = {}
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.is_extendable = false
ChargeModule_pb.GETCHARGEINFOREQUEST_MSG.extensions = {}
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.name = "id"
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.full_name = ".GetMonthCardBonusReply.id"
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.number = 1
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.index = 0
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.label = 1
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.has_default_value = false
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.default_value = 0
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.type = 5
ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD.cpp_type = 1
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.name = "GetMonthCardBonusReply"
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.full_name = ".GetMonthCardBonusReply"
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.nested_types = {}
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.enum_types = {}
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.fields = {
	ChargeModule_pb.GETMONTHCARDBONUSREPLYIDFIELD
}
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.is_extendable = false
ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG.extensions = {}
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.name = "infos"
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.full_name = ".GetChargeInfoReply.infos"
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.number = 1
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.index = 0
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.label = 3
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.has_default_value = false
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.default_value = {}
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.message_type = ChargeModule_pb.CHARGEINFO_MSG
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.type = 11
ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD.cpp_type = 10
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.name = "sandboxEnable"
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.full_name = ".GetChargeInfoReply.sandboxEnable"
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.number = 2
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.index = 1
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.label = 1
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.has_default_value = false
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.default_value = false
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.type = 8
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD.cpp_type = 7
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.name = "sandboxBalance"
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.full_name = ".GetChargeInfoReply.sandboxBalance"
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.number = 3
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.index = 2
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.label = 1
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.has_default_value = false
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.default_value = 0
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.type = 5
ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD.cpp_type = 1
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.name = "GetChargeInfoReply"
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.full_name = ".GetChargeInfoReply"
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.nested_types = {}
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.enum_types = {}
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.fields = {
	ChargeModule_pb.GETCHARGEINFOREPLYINFOSFIELD,
	ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXENABLEFIELD,
	ChargeModule_pb.GETCHARGEINFOREPLYSANDBOXBALANCEFIELD
}
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.is_extendable = false
ChargeModule_pb.GETCHARGEINFOREPLY_MSG.extensions = {}
ChargeModule_pb.NEWORDERREPLYIDFIELD.name = "id"
ChargeModule_pb.NEWORDERREPLYIDFIELD.full_name = ".NewOrderReply.id"
ChargeModule_pb.NEWORDERREPLYIDFIELD.number = 1
ChargeModule_pb.NEWORDERREPLYIDFIELD.index = 0
ChargeModule_pb.NEWORDERREPLYIDFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYIDFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYIDFIELD.default_value = 0
ChargeModule_pb.NEWORDERREPLYIDFIELD.type = 5
ChargeModule_pb.NEWORDERREPLYIDFIELD.cpp_type = 1
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.name = "passBackParam"
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.full_name = ".NewOrderReply.passBackParam"
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.number = 2
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.index = 1
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.default_value = ""
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.type = 9
ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD.cpp_type = 9
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.name = "notifyUrl"
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.full_name = ".NewOrderReply.notifyUrl"
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.number = 3
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.index = 2
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.default_value = ""
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.type = 9
ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD.cpp_type = 9
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.name = "gameOrderId"
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.full_name = ".NewOrderReply.gameOrderId"
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.number = 4
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.index = 3
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.default_value = 0
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.type = 3
ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD.cpp_type = 2
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.name = "timestamp"
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.full_name = ".NewOrderReply.timestamp"
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.number = 5
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.index = 4
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.default_value = 0
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.type = 3
ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD.cpp_type = 2
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.name = "sign"
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.full_name = ".NewOrderReply.sign"
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.number = 6
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.index = 5
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.default_value = ""
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.type = 9
ChargeModule_pb.NEWORDERREPLYSIGNFIELD.cpp_type = 9
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.name = "serverId"
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.full_name = ".NewOrderReply.serverId"
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.number = 7
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.index = 6
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.label = 1
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.default_value = 0
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.type = 5
ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD.cpp_type = 1
ChargeModule_pb.NEWORDERREPLY_MSG.name = "NewOrderReply"
ChargeModule_pb.NEWORDERREPLY_MSG.full_name = ".NewOrderReply"
ChargeModule_pb.NEWORDERREPLY_MSG.nested_types = {}
ChargeModule_pb.NEWORDERREPLY_MSG.enum_types = {}
ChargeModule_pb.NEWORDERREPLY_MSG.fields = {
	ChargeModule_pb.NEWORDERREPLYIDFIELD,
	ChargeModule_pb.NEWORDERREPLYPASSBACKPARAMFIELD,
	ChargeModule_pb.NEWORDERREPLYNOTIFYURLFIELD,
	ChargeModule_pb.NEWORDERREPLYGAMEORDERIDFIELD,
	ChargeModule_pb.NEWORDERREPLYTIMESTAMPFIELD,
	ChargeModule_pb.NEWORDERREPLYSIGNFIELD,
	ChargeModule_pb.NEWORDERREPLYSERVERIDFIELD
}
ChargeModule_pb.NEWORDERREPLY_MSG.is_extendable = false
ChargeModule_pb.NEWORDERREPLY_MSG.extensions = {}
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.name = "id"
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.full_name = ".OrderCompletePush.id"
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.number = 1
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.index = 0
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.label = 1
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.has_default_value = false
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.default_value = 0
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.type = 5
ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD.cpp_type = 1
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.name = "gameOrderId"
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.full_name = ".OrderCompletePush.gameOrderId"
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.number = 2
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.index = 1
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.label = 1
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.has_default_value = false
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.default_value = 0
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.type = 3
ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD.cpp_type = 2
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.name = "OrderCompletePush"
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.full_name = ".OrderCompletePush"
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.nested_types = {}
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.enum_types = {}
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.fields = {
	ChargeModule_pb.ORDERCOMPLETEPUSHIDFIELD,
	ChargeModule_pb.ORDERCOMPLETEPUSHGAMEORDERIDFIELD
}
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.is_extendable = false
ChargeModule_pb.ORDERCOMPLETEPUSH_MSG.extensions = {}
ChargeModule_pb.NEWORDERREQUESTIDFIELD.name = "id"
ChargeModule_pb.NEWORDERREQUESTIDFIELD.full_name = ".NewOrderRequest.id"
ChargeModule_pb.NEWORDERREQUESTIDFIELD.number = 1
ChargeModule_pb.NEWORDERREQUESTIDFIELD.index = 0
ChargeModule_pb.NEWORDERREQUESTIDFIELD.label = 1
ChargeModule_pb.NEWORDERREQUESTIDFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREQUESTIDFIELD.default_value = 0
ChargeModule_pb.NEWORDERREQUESTIDFIELD.type = 5
ChargeModule_pb.NEWORDERREQUESTIDFIELD.cpp_type = 1
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.name = "selectionInfos"
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.full_name = ".NewOrderRequest.selectionInfos"
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.number = 2
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.index = 1
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.label = 3
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.has_default_value = false
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.default_value = {}
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.message_type = ChargeModule_pb.SELECTIONINFO_MSG
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.type = 11
ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD.cpp_type = 10
ChargeModule_pb.NEWORDERREQUEST_MSG.name = "NewOrderRequest"
ChargeModule_pb.NEWORDERREQUEST_MSG.full_name = ".NewOrderRequest"
ChargeModule_pb.NEWORDERREQUEST_MSG.nested_types = {}
ChargeModule_pb.NEWORDERREQUEST_MSG.enum_types = {}
ChargeModule_pb.NEWORDERREQUEST_MSG.fields = {
	ChargeModule_pb.NEWORDERREQUESTIDFIELD,
	ChargeModule_pb.NEWORDERREQUESTSELECTIONINFOSFIELD
}
ChargeModule_pb.NEWORDERREQUEST_MSG.is_extendable = false
ChargeModule_pb.NEWORDERREQUEST_MSG.extensions = {}
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.name = "gameOrderId"
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.full_name = ".SandboxChargeRequset.gameOrderId"
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.number = 1
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.index = 0
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.label = 1
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.has_default_value = false
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.default_value = 0
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.type = 3
ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD.cpp_type = 2
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.name = "SandboxChargeRequset"
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.full_name = ".SandboxChargeRequset"
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.nested_types = {}
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.enum_types = {}
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.fields = {
	ChargeModule_pb.SANDBOXCHARGEREQUSETGAMEORDERIDFIELD
}
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.is_extendable = false
ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG.extensions = {}
ChargeModule_pb.CHARGEINFOIDFIELD.name = "id"
ChargeModule_pb.CHARGEINFOIDFIELD.full_name = ".ChargeInfo.id"
ChargeModule_pb.CHARGEINFOIDFIELD.number = 1
ChargeModule_pb.CHARGEINFOIDFIELD.index = 0
ChargeModule_pb.CHARGEINFOIDFIELD.label = 1
ChargeModule_pb.CHARGEINFOIDFIELD.has_default_value = false
ChargeModule_pb.CHARGEINFOIDFIELD.default_value = 0
ChargeModule_pb.CHARGEINFOIDFIELD.type = 5
ChargeModule_pb.CHARGEINFOIDFIELD.cpp_type = 1
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.name = "buyCount"
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.full_name = ".ChargeInfo.buyCount"
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.number = 2
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.index = 1
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.label = 1
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.has_default_value = false
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.default_value = 0
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.type = 5
ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD.cpp_type = 1
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.name = "firstCharge"
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.full_name = ".ChargeInfo.firstCharge"
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.number = 3
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.index = 2
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.label = 1
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.has_default_value = false
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.default_value = false
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.type = 8
ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD.cpp_type = 7
ChargeModule_pb.CHARGEINFO_MSG.name = "ChargeInfo"
ChargeModule_pb.CHARGEINFO_MSG.full_name = ".ChargeInfo"
ChargeModule_pb.CHARGEINFO_MSG.nested_types = {}
ChargeModule_pb.CHARGEINFO_MSG.enum_types = {}
ChargeModule_pb.CHARGEINFO_MSG.fields = {
	ChargeModule_pb.CHARGEINFOIDFIELD,
	ChargeModule_pb.CHARGEINFOBUYCOUNTFIELD,
	ChargeModule_pb.CHARGEINFOFIRSTCHARGEFIELD
}
ChargeModule_pb.CHARGEINFO_MSG.is_extendable = false
ChargeModule_pb.CHARGEINFO_MSG.extensions = {}
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.name = "gameOrderId"
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.full_name = ".SandboxChargeReply.gameOrderId"
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.number = 1
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.index = 0
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.label = 1
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.has_default_value = false
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.default_value = 0
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.type = 3
ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD.cpp_type = 2
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.name = "sandboxBalance"
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.full_name = ".SandboxChargeReply.sandboxBalance"
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.number = 2
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.index = 1
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.label = 1
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.has_default_value = false
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.default_value = 0
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.type = 5
ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD.cpp_type = 1
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.name = "SandboxChargeReply"
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.full_name = ".SandboxChargeReply"
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.nested_types = {}
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.enum_types = {}
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.fields = {
	ChargeModule_pb.SANDBOXCHARGEREPLYGAMEORDERIDFIELD,
	ChargeModule_pb.SANDBOXCHARGEREPLYSANDBOXBALANCEFIELD
}
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.is_extendable = false
ChargeModule_pb.SANDBOXCHARGEREPLY_MSG.extensions = {}
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.name = "goodsIds"
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.full_name = ".ReadChargeNewRequest.goodsIds"
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.number = 1
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.index = 0
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.label = 3
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.has_default_value = false
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.default_value = {}
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.type = 5
ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD.cpp_type = 1
ChargeModule_pb.READCHARGENEWREQUEST_MSG.name = "ReadChargeNewRequest"
ChargeModule_pb.READCHARGENEWREQUEST_MSG.full_name = ".ReadChargeNewRequest"
ChargeModule_pb.READCHARGENEWREQUEST_MSG.nested_types = {}
ChargeModule_pb.READCHARGENEWREQUEST_MSG.enum_types = {}
ChargeModule_pb.READCHARGENEWREQUEST_MSG.fields = {
	ChargeModule_pb.READCHARGENEWREQUESTGOODSIDSFIELD
}
ChargeModule_pb.READCHARGENEWREQUEST_MSG.is_extendable = false
ChargeModule_pb.READCHARGENEWREQUEST_MSG.extensions = {}
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.name = "regionId"
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.full_name = ".SelectionInfo.regionId"
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.number = 1
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.index = 0
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.label = 1
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.has_default_value = false
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.default_value = 0
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.type = 5
ChargeModule_pb.SELECTIONINFOREGIONIDFIELD.cpp_type = 1
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.name = "selectionPos"
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.full_name = ".SelectionInfo.selectionPos"
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.number = 2
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.index = 1
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.label = 1
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.has_default_value = false
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.default_value = 0
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.type = 5
ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD.cpp_type = 1
ChargeModule_pb.SELECTIONINFO_MSG.name = "SelectionInfo"
ChargeModule_pb.SELECTIONINFO_MSG.full_name = ".SelectionInfo"
ChargeModule_pb.SELECTIONINFO_MSG.nested_types = {}
ChargeModule_pb.SELECTIONINFO_MSG.enum_types = {}
ChargeModule_pb.SELECTIONINFO_MSG.fields = {
	ChargeModule_pb.SELECTIONINFOREGIONIDFIELD,
	ChargeModule_pb.SELECTIONINFOSELECTIONPOSFIELD
}
ChargeModule_pb.SELECTIONINFO_MSG.is_extendable = false
ChargeModule_pb.SELECTIONINFO_MSG.extensions = {}
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.name = "GetMonthCardInfoRequest"
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.full_name = ".GetMonthCardInfoRequest"
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.nested_types = {}
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.enum_types = {}
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.fields = {}
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.is_extendable = false
ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG.extensions = {}
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.name = "infos"
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.full_name = ".GetMonthCardInfoReply.infos"
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.number = 1
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.index = 0
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.label = 3
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.has_default_value = false
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.default_value = {}
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.message_type = ChargeModule_pb.MONTHCARDINFO_MSG
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.type = 11
ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD.cpp_type = 10
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.name = "GetMonthCardInfoReply"
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.full_name = ".GetMonthCardInfoReply"
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.nested_types = {}
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.enum_types = {}
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.fields = {
	ChargeModule_pb.GETMONTHCARDINFOREPLYINFOSFIELD
}
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.is_extendable = false
ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG.extensions = {}
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.name = "goodsIds"
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.full_name = ".ReadChargeNewReply.goodsIds"
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.number = 1
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.index = 0
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.label = 3
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.has_default_value = false
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.default_value = {}
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.type = 5
ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD.cpp_type = 1
ChargeModule_pb.READCHARGENEWREPLY_MSG.name = "ReadChargeNewReply"
ChargeModule_pb.READCHARGENEWREPLY_MSG.full_name = ".ReadChargeNewReply"
ChargeModule_pb.READCHARGENEWREPLY_MSG.nested_types = {}
ChargeModule_pb.READCHARGENEWREPLY_MSG.enum_types = {}
ChargeModule_pb.READCHARGENEWREPLY_MSG.fields = {
	ChargeModule_pb.READCHARGENEWREPLYGOODSIDSFIELD
}
ChargeModule_pb.READCHARGENEWREPLY_MSG.is_extendable = false
ChargeModule_pb.READCHARGENEWREPLY_MSG.extensions = {}
ChargeModule_pb.MONTHCARDINFOIDFIELD.name = "id"
ChargeModule_pb.MONTHCARDINFOIDFIELD.full_name = ".MonthCardInfo.id"
ChargeModule_pb.MONTHCARDINFOIDFIELD.number = 1
ChargeModule_pb.MONTHCARDINFOIDFIELD.index = 0
ChargeModule_pb.MONTHCARDINFOIDFIELD.label = 1
ChargeModule_pb.MONTHCARDINFOIDFIELD.has_default_value = false
ChargeModule_pb.MONTHCARDINFOIDFIELD.default_value = 0
ChargeModule_pb.MONTHCARDINFOIDFIELD.type = 5
ChargeModule_pb.MONTHCARDINFOIDFIELD.cpp_type = 1
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.name = "expireTime"
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.full_name = ".MonthCardInfo.expireTime"
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.number = 2
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.index = 1
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.label = 1
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.has_default_value = false
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.default_value = 0
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.type = 5
ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD.cpp_type = 1
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.name = "hasGetBonus"
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.full_name = ".MonthCardInfo.hasGetBonus"
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.number = 3
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.index = 2
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.label = 1
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.has_default_value = false
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.default_value = false
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.type = 8
ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD.cpp_type = 7
ChargeModule_pb.MONTHCARDINFO_MSG.name = "MonthCardInfo"
ChargeModule_pb.MONTHCARDINFO_MSG.full_name = ".MonthCardInfo"
ChargeModule_pb.MONTHCARDINFO_MSG.nested_types = {}
ChargeModule_pb.MONTHCARDINFO_MSG.enum_types = {}
ChargeModule_pb.MONTHCARDINFO_MSG.fields = {
	ChargeModule_pb.MONTHCARDINFOIDFIELD,
	ChargeModule_pb.MONTHCARDINFOEXPIRETIMEFIELD,
	ChargeModule_pb.MONTHCARDINFOHASGETBONUSFIELD
}
ChargeModule_pb.MONTHCARDINFO_MSG.is_extendable = false
ChargeModule_pb.MONTHCARDINFO_MSG.extensions = {}
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.name = "id"
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.full_name = ".GetMonthCardBonusRequest.id"
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.number = 1
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.index = 0
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.label = 1
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.has_default_value = false
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.default_value = 0
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.type = 5
ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD.cpp_type = 1
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.name = "GetMonthCardBonusRequest"
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.full_name = ".GetMonthCardBonusRequest"
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.nested_types = {}
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.enum_types = {}
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.fields = {
	ChargeModule_pb.GETMONTHCARDBONUSREQUESTIDFIELD
}
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.is_extendable = false
ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG.extensions = {}
ChargeModule_pb.ChargeInfo = protobuf.Message(ChargeModule_pb.CHARGEINFO_MSG)
ChargeModule_pb.GetChargeInfoReply = protobuf.Message(ChargeModule_pb.GETCHARGEINFOREPLY_MSG)
ChargeModule_pb.GetChargeInfoRequest = protobuf.Message(ChargeModule_pb.GETCHARGEINFOREQUEST_MSG)
ChargeModule_pb.GetMonthCardBonusReply = protobuf.Message(ChargeModule_pb.GETMONTHCARDBONUSREPLY_MSG)
ChargeModule_pb.GetMonthCardBonusRequest = protobuf.Message(ChargeModule_pb.GETMONTHCARDBONUSREQUEST_MSG)
ChargeModule_pb.GetMonthCardInfoReply = protobuf.Message(ChargeModule_pb.GETMONTHCARDINFOREPLY_MSG)
ChargeModule_pb.GetMonthCardInfoRequest = protobuf.Message(ChargeModule_pb.GETMONTHCARDINFOREQUEST_MSG)
ChargeModule_pb.MonthCardInfo = protobuf.Message(ChargeModule_pb.MONTHCARDINFO_MSG)
ChargeModule_pb.NewOrderReply = protobuf.Message(ChargeModule_pb.NEWORDERREPLY_MSG)
ChargeModule_pb.NewOrderRequest = protobuf.Message(ChargeModule_pb.NEWORDERREQUEST_MSG)
ChargeModule_pb.OrderCompletePush = protobuf.Message(ChargeModule_pb.ORDERCOMPLETEPUSH_MSG)
ChargeModule_pb.ReadChargeNewReply = protobuf.Message(ChargeModule_pb.READCHARGENEWREPLY_MSG)
ChargeModule_pb.ReadChargeNewRequest = protobuf.Message(ChargeModule_pb.READCHARGENEWREQUEST_MSG)
ChargeModule_pb.SandboxChargeReply = protobuf.Message(ChargeModule_pb.SANDBOXCHARGEREPLY_MSG)
ChargeModule_pb.SandboxChargeRequset = protobuf.Message(ChargeModule_pb.SANDBOXCHARGEREQUSET_MSG)
ChargeModule_pb.SelectionInfo = protobuf.Message(ChargeModule_pb.SELECTIONINFO_MSG)

return ChargeModule_pb

-- chunkname: @modules/proto/StoreModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.StoreModule_pb", package.seeall)

local StoreModule_pb = {}

StoreModule_pb.GETSTOREINFOSREPLY_MSG = protobuf.Descriptor()
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD = protobuf.FieldDescriptor()
StoreModule_pb.GETSTOREINFOSREQUEST_MSG = protobuf.Descriptor()
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREQUEST_MSG = protobuf.Descriptor()
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREQUESTNUMFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREPLY_MSG = protobuf.Descriptor()
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREPLYNUMFIELD = protobuf.FieldDescriptor()
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD = protobuf.FieldDescriptor()
StoreModule_pb.GOODSINFO_MSG = protobuf.Descriptor()
StoreModule_pb.GOODSINFOGOODSIDFIELD = protobuf.FieldDescriptor()
StoreModule_pb.GOODSINFOBUYCOUNTFIELD = protobuf.FieldDescriptor()
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD = protobuf.FieldDescriptor()
StoreModule_pb.STOREINFO_MSG = protobuf.Descriptor()
StoreModule_pb.STOREINFOIDFIELD = protobuf.FieldDescriptor()
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD = protobuf.FieldDescriptor()
StoreModule_pb.STOREINFOGOODSINFOSFIELD = protobuf.FieldDescriptor()
StoreModule_pb.STOREINFOOFFLINETIMEFIELD = protobuf.FieldDescriptor()
StoreModule_pb.READSTORENEWREPLY_MSG = protobuf.Descriptor()
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD = protobuf.FieldDescriptor()
StoreModule_pb.READSTORENEWREQUEST_MSG = protobuf.Descriptor()
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD = protobuf.FieldDescriptor()
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.name = "storeInfos"
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.full_name = ".GetStoreInfosReply.storeInfos"
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.number = 1
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.index = 0
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.label = 3
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.has_default_value = false
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.default_value = {}
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.message_type = StoreModule_pb.STOREINFO_MSG
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.type = 11
StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD.cpp_type = 10
StoreModule_pb.GETSTOREINFOSREPLY_MSG.name = "GetStoreInfosReply"
StoreModule_pb.GETSTOREINFOSREPLY_MSG.full_name = ".GetStoreInfosReply"
StoreModule_pb.GETSTOREINFOSREPLY_MSG.nested_types = {}
StoreModule_pb.GETSTOREINFOSREPLY_MSG.enum_types = {}
StoreModule_pb.GETSTOREINFOSREPLY_MSG.fields = {
	StoreModule_pb.GETSTOREINFOSREPLYSTOREINFOSFIELD
}
StoreModule_pb.GETSTOREINFOSREPLY_MSG.is_extendable = false
StoreModule_pb.GETSTOREINFOSREPLY_MSG.extensions = {}
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.name = "storeIds"
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.full_name = ".GetStoreInfosRequest.storeIds"
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.number = 1
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.index = 0
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.label = 3
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.has_default_value = false
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.default_value = {}
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.type = 5
StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD.cpp_type = 1
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.name = "GetStoreInfosRequest"
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.full_name = ".GetStoreInfosRequest"
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.nested_types = {}
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.enum_types = {}
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.fields = {
	StoreModule_pb.GETSTOREINFOSREQUESTSTOREIDSFIELD
}
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.is_extendable = false
StoreModule_pb.GETSTOREINFOSREQUEST_MSG.extensions = {}
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.name = "storeId"
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.full_name = ".BuyGoodsRequest.storeId"
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.number = 1
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.index = 0
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.label = 2
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.default_value = 0
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.type = 5
StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.name = "goodsId"
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.full_name = ".BuyGoodsRequest.goodsId"
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.number = 2
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.index = 1
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.label = 2
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.default_value = 0
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.type = 5
StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.name = "num"
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.full_name = ".BuyGoodsRequest.num"
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.number = 3
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.index = 2
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.label = 2
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.default_value = 0
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.type = 5
StoreModule_pb.BUYGOODSREQUESTNUMFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.name = "selectCost"
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.full_name = ".BuyGoodsRequest.selectCost"
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.number = 4
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.index = 3
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.label = 1
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.default_value = 0
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.type = 5
StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREQUEST_MSG.name = "BuyGoodsRequest"
StoreModule_pb.BUYGOODSREQUEST_MSG.full_name = ".BuyGoodsRequest"
StoreModule_pb.BUYGOODSREQUEST_MSG.nested_types = {}
StoreModule_pb.BUYGOODSREQUEST_MSG.enum_types = {}
StoreModule_pb.BUYGOODSREQUEST_MSG.fields = {
	StoreModule_pb.BUYGOODSREQUESTSTOREIDFIELD,
	StoreModule_pb.BUYGOODSREQUESTGOODSIDFIELD,
	StoreModule_pb.BUYGOODSREQUESTNUMFIELD,
	StoreModule_pb.BUYGOODSREQUESTSELECTCOSTFIELD
}
StoreModule_pb.BUYGOODSREQUEST_MSG.is_extendable = false
StoreModule_pb.BUYGOODSREQUEST_MSG.extensions = {}
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.name = "storeId"
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.full_name = ".BuyGoodsReply.storeId"
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.number = 1
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.index = 0
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.label = 2
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.default_value = 0
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.type = 5
StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.name = "goodsId"
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.full_name = ".BuyGoodsReply.goodsId"
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.number = 2
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.index = 1
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.label = 2
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.default_value = 0
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.type = 5
StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREPLYNUMFIELD.name = "num"
StoreModule_pb.BUYGOODSREPLYNUMFIELD.full_name = ".BuyGoodsReply.num"
StoreModule_pb.BUYGOODSREPLYNUMFIELD.number = 3
StoreModule_pb.BUYGOODSREPLYNUMFIELD.index = 2
StoreModule_pb.BUYGOODSREPLYNUMFIELD.label = 2
StoreModule_pb.BUYGOODSREPLYNUMFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREPLYNUMFIELD.default_value = 0
StoreModule_pb.BUYGOODSREPLYNUMFIELD.type = 5
StoreModule_pb.BUYGOODSREPLYNUMFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.name = "selectCost"
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.full_name = ".BuyGoodsReply.selectCost"
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.number = 4
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.index = 3
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.label = 1
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.has_default_value = false
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.default_value = 0
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.type = 5
StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD.cpp_type = 1
StoreModule_pb.BUYGOODSREPLY_MSG.name = "BuyGoodsReply"
StoreModule_pb.BUYGOODSREPLY_MSG.full_name = ".BuyGoodsReply"
StoreModule_pb.BUYGOODSREPLY_MSG.nested_types = {}
StoreModule_pb.BUYGOODSREPLY_MSG.enum_types = {}
StoreModule_pb.BUYGOODSREPLY_MSG.fields = {
	StoreModule_pb.BUYGOODSREPLYSTOREIDFIELD,
	StoreModule_pb.BUYGOODSREPLYGOODSIDFIELD,
	StoreModule_pb.BUYGOODSREPLYNUMFIELD,
	StoreModule_pb.BUYGOODSREPLYSELECTCOSTFIELD
}
StoreModule_pb.BUYGOODSREPLY_MSG.is_extendable = false
StoreModule_pb.BUYGOODSREPLY_MSG.extensions = {}
StoreModule_pb.GOODSINFOGOODSIDFIELD.name = "goodsId"
StoreModule_pb.GOODSINFOGOODSIDFIELD.full_name = ".GoodsInfo.goodsId"
StoreModule_pb.GOODSINFOGOODSIDFIELD.number = 1
StoreModule_pb.GOODSINFOGOODSIDFIELD.index = 0
StoreModule_pb.GOODSINFOGOODSIDFIELD.label = 2
StoreModule_pb.GOODSINFOGOODSIDFIELD.has_default_value = false
StoreModule_pb.GOODSINFOGOODSIDFIELD.default_value = 0
StoreModule_pb.GOODSINFOGOODSIDFIELD.type = 5
StoreModule_pb.GOODSINFOGOODSIDFIELD.cpp_type = 1
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.name = "buyCount"
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.full_name = ".GoodsInfo.buyCount"
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.number = 2
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.index = 1
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.label = 2
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.has_default_value = false
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.default_value = 0
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.type = 5
StoreModule_pb.GOODSINFOBUYCOUNTFIELD.cpp_type = 1
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.name = "offlineTime"
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.full_name = ".GoodsInfo.offlineTime"
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.number = 3
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.index = 2
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.label = 1
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.has_default_value = false
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.default_value = 0
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.type = 3
StoreModule_pb.GOODSINFOOFFLINETIMEFIELD.cpp_type = 2
StoreModule_pb.GOODSINFO_MSG.name = "GoodsInfo"
StoreModule_pb.GOODSINFO_MSG.full_name = ".GoodsInfo"
StoreModule_pb.GOODSINFO_MSG.nested_types = {}
StoreModule_pb.GOODSINFO_MSG.enum_types = {}
StoreModule_pb.GOODSINFO_MSG.fields = {
	StoreModule_pb.GOODSINFOGOODSIDFIELD,
	StoreModule_pb.GOODSINFOBUYCOUNTFIELD,
	StoreModule_pb.GOODSINFOOFFLINETIMEFIELD
}
StoreModule_pb.GOODSINFO_MSG.is_extendable = false
StoreModule_pb.GOODSINFO_MSG.extensions = {}
StoreModule_pb.STOREINFOIDFIELD.name = "id"
StoreModule_pb.STOREINFOIDFIELD.full_name = ".StoreInfo.id"
StoreModule_pb.STOREINFOIDFIELD.number = 1
StoreModule_pb.STOREINFOIDFIELD.index = 0
StoreModule_pb.STOREINFOIDFIELD.label = 2
StoreModule_pb.STOREINFOIDFIELD.has_default_value = false
StoreModule_pb.STOREINFOIDFIELD.default_value = 0
StoreModule_pb.STOREINFOIDFIELD.type = 5
StoreModule_pb.STOREINFOIDFIELD.cpp_type = 1
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.name = "nextRefreshTime"
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.full_name = ".StoreInfo.nextRefreshTime"
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.number = 2
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.index = 1
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.label = 2
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.has_default_value = false
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.default_value = 0
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.type = 3
StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD.cpp_type = 2
StoreModule_pb.STOREINFOGOODSINFOSFIELD.name = "goodsInfos"
StoreModule_pb.STOREINFOGOODSINFOSFIELD.full_name = ".StoreInfo.goodsInfos"
StoreModule_pb.STOREINFOGOODSINFOSFIELD.number = 3
StoreModule_pb.STOREINFOGOODSINFOSFIELD.index = 2
StoreModule_pb.STOREINFOGOODSINFOSFIELD.label = 3
StoreModule_pb.STOREINFOGOODSINFOSFIELD.has_default_value = false
StoreModule_pb.STOREINFOGOODSINFOSFIELD.default_value = {}
StoreModule_pb.STOREINFOGOODSINFOSFIELD.message_type = StoreModule_pb.GOODSINFO_MSG
StoreModule_pb.STOREINFOGOODSINFOSFIELD.type = 11
StoreModule_pb.STOREINFOGOODSINFOSFIELD.cpp_type = 10
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.name = "offlineTime"
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.full_name = ".StoreInfo.offlineTime"
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.number = 4
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.index = 3
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.label = 1
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.has_default_value = false
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.default_value = 0
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.type = 3
StoreModule_pb.STOREINFOOFFLINETIMEFIELD.cpp_type = 2
StoreModule_pb.STOREINFO_MSG.name = "StoreInfo"
StoreModule_pb.STOREINFO_MSG.full_name = ".StoreInfo"
StoreModule_pb.STOREINFO_MSG.nested_types = {}
StoreModule_pb.STOREINFO_MSG.enum_types = {}
StoreModule_pb.STOREINFO_MSG.fields = {
	StoreModule_pb.STOREINFOIDFIELD,
	StoreModule_pb.STOREINFONEXTREFRESHTIMEFIELD,
	StoreModule_pb.STOREINFOGOODSINFOSFIELD,
	StoreModule_pb.STOREINFOOFFLINETIMEFIELD
}
StoreModule_pb.STOREINFO_MSG.is_extendable = false
StoreModule_pb.STOREINFO_MSG.extensions = {}
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.name = "goodsIds"
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.full_name = ".ReadStoreNewReply.goodsIds"
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.number = 1
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.index = 0
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.label = 3
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.has_default_value = false
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.default_value = {}
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.type = 5
StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD.cpp_type = 1
StoreModule_pb.READSTORENEWREPLY_MSG.name = "ReadStoreNewReply"
StoreModule_pb.READSTORENEWREPLY_MSG.full_name = ".ReadStoreNewReply"
StoreModule_pb.READSTORENEWREPLY_MSG.nested_types = {}
StoreModule_pb.READSTORENEWREPLY_MSG.enum_types = {}
StoreModule_pb.READSTORENEWREPLY_MSG.fields = {
	StoreModule_pb.READSTORENEWREPLYGOODSIDSFIELD
}
StoreModule_pb.READSTORENEWREPLY_MSG.is_extendable = false
StoreModule_pb.READSTORENEWREPLY_MSG.extensions = {}
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.name = "goodsIds"
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.full_name = ".ReadStoreNewRequest.goodsIds"
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.number = 1
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.index = 0
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.label = 3
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.has_default_value = false
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.default_value = {}
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.type = 5
StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD.cpp_type = 1
StoreModule_pb.READSTORENEWREQUEST_MSG.name = "ReadStoreNewRequest"
StoreModule_pb.READSTORENEWREQUEST_MSG.full_name = ".ReadStoreNewRequest"
StoreModule_pb.READSTORENEWREQUEST_MSG.nested_types = {}
StoreModule_pb.READSTORENEWREQUEST_MSG.enum_types = {}
StoreModule_pb.READSTORENEWREQUEST_MSG.fields = {
	StoreModule_pb.READSTORENEWREQUESTGOODSIDSFIELD
}
StoreModule_pb.READSTORENEWREQUEST_MSG.is_extendable = false
StoreModule_pb.READSTORENEWREQUEST_MSG.extensions = {}
StoreModule_pb.BuyGoodsReply = protobuf.Message(StoreModule_pb.BUYGOODSREPLY_MSG)
StoreModule_pb.BuyGoodsRequest = protobuf.Message(StoreModule_pb.BUYGOODSREQUEST_MSG)
StoreModule_pb.GetStoreInfosReply = protobuf.Message(StoreModule_pb.GETSTOREINFOSREPLY_MSG)
StoreModule_pb.GetStoreInfosRequest = protobuf.Message(StoreModule_pb.GETSTOREINFOSREQUEST_MSG)
StoreModule_pb.GoodsInfo = protobuf.Message(StoreModule_pb.GOODSINFO_MSG)
StoreModule_pb.ReadStoreNewReply = protobuf.Message(StoreModule_pb.READSTORENEWREPLY_MSG)
StoreModule_pb.ReadStoreNewRequest = protobuf.Message(StoreModule_pb.READSTORENEWREQUEST_MSG)
StoreModule_pb.StoreInfo = protobuf.Message(StoreModule_pb.STOREINFO_MSG)

return StoreModule_pb

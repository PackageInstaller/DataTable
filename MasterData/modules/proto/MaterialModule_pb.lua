-- chunkname: @modules/proto/MaterialModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.MaterialModule_pb", package.seeall)

local MaterialModule_pb = {}

MaterialModule_pb.MATERIALCHANGEPUSH_MSG = protobuf.Descriptor()
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.MATERIALDATA_MSG = protobuf.Descriptor()
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.MATERIALDATAMATERILIDFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.MATERIALDATAQUANTITYFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.M2QENTRY_MSG = protobuf.Descriptor()
MaterialModule_pb.M2QENTRYMATERIALIDFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.M2QENTRYQUANTITYFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.M2QENTRYTIMEFIELD = protobuf.FieldDescriptor()
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.name = "dataList"
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.full_name = ".MaterialChangePush.dataList"
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.number = 1
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.index = 0
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.label = 3
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.has_default_value = false
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.default_value = {}
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.message_type = MaterialModule_pb.MATERIALDATA_MSG
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.type = 11
MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD.cpp_type = 10
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.name = "getApproach"
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.full_name = ".MaterialChangePush.getApproach"
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.number = 2
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.index = 1
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.label = 1
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.has_default_value = false
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.default_value = 0
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.type = 13
MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD.cpp_type = 3
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.name = "MaterialChangePush"
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.full_name = ".MaterialChangePush"
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.nested_types = {}
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.enum_types = {}
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.fields = {
	MaterialModule_pb.MATERIALCHANGEPUSHDATALISTFIELD,
	MaterialModule_pb.MATERIALCHANGEPUSHGETAPPROACHFIELD
}
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.is_extendable = false
MaterialModule_pb.MATERIALCHANGEPUSH_MSG.extensions = {}
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.name = "materilType"
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.full_name = ".MaterialData.materilType"
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.number = 1
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.index = 0
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.label = 1
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.has_default_value = false
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.default_value = 0
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.type = 13
MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD.cpp_type = 3
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.name = "materilId"
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.full_name = ".MaterialData.materilId"
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.number = 2
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.index = 1
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.label = 1
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.has_default_value = false
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.default_value = 0
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.type = 13
MaterialModule_pb.MATERIALDATAMATERILIDFIELD.cpp_type = 3
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.name = "quantity"
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.full_name = ".MaterialData.quantity"
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.number = 3
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.index = 2
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.label = 1
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.has_default_value = false
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.default_value = 0
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.type = 5
MaterialModule_pb.MATERIALDATAQUANTITYFIELD.cpp_type = 1
MaterialModule_pb.MATERIALDATA_MSG.name = "MaterialData"
MaterialModule_pb.MATERIALDATA_MSG.full_name = ".MaterialData"
MaterialModule_pb.MATERIALDATA_MSG.nested_types = {}
MaterialModule_pb.MATERIALDATA_MSG.enum_types = {}
MaterialModule_pb.MATERIALDATA_MSG.fields = {
	MaterialModule_pb.MATERIALDATAMATERILTYPEFIELD,
	MaterialModule_pb.MATERIALDATAMATERILIDFIELD,
	MaterialModule_pb.MATERIALDATAQUANTITYFIELD
}
MaterialModule_pb.MATERIALDATA_MSG.is_extendable = false
MaterialModule_pb.MATERIALDATA_MSG.extensions = {}
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.name = "materialId"
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.full_name = ".M2QEntry.materialId"
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.number = 1
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.index = 0
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.label = 1
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.has_default_value = false
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.default_value = 0
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.type = 13
MaterialModule_pb.M2QENTRYMATERIALIDFIELD.cpp_type = 3
MaterialModule_pb.M2QENTRYQUANTITYFIELD.name = "quantity"
MaterialModule_pb.M2QENTRYQUANTITYFIELD.full_name = ".M2QEntry.quantity"
MaterialModule_pb.M2QENTRYQUANTITYFIELD.number = 2
MaterialModule_pb.M2QENTRYQUANTITYFIELD.index = 1
MaterialModule_pb.M2QENTRYQUANTITYFIELD.label = 1
MaterialModule_pb.M2QENTRYQUANTITYFIELD.has_default_value = false
MaterialModule_pb.M2QENTRYQUANTITYFIELD.default_value = 0
MaterialModule_pb.M2QENTRYQUANTITYFIELD.type = 5
MaterialModule_pb.M2QENTRYQUANTITYFIELD.cpp_type = 1
MaterialModule_pb.M2QENTRYTIMEFIELD.name = "time"
MaterialModule_pb.M2QENTRYTIMEFIELD.full_name = ".M2QEntry.time"
MaterialModule_pb.M2QENTRYTIMEFIELD.number = 3
MaterialModule_pb.M2QENTRYTIMEFIELD.index = 2
MaterialModule_pb.M2QENTRYTIMEFIELD.label = 1
MaterialModule_pb.M2QENTRYTIMEFIELD.has_default_value = false
MaterialModule_pb.M2QENTRYTIMEFIELD.default_value = 0
MaterialModule_pb.M2QENTRYTIMEFIELD.type = 3
MaterialModule_pb.M2QENTRYTIMEFIELD.cpp_type = 2
MaterialModule_pb.M2QENTRY_MSG.name = "M2QEntry"
MaterialModule_pb.M2QENTRY_MSG.full_name = ".M2QEntry"
MaterialModule_pb.M2QENTRY_MSG.nested_types = {}
MaterialModule_pb.M2QENTRY_MSG.enum_types = {}
MaterialModule_pb.M2QENTRY_MSG.fields = {
	MaterialModule_pb.M2QENTRYMATERIALIDFIELD,
	MaterialModule_pb.M2QENTRYQUANTITYFIELD,
	MaterialModule_pb.M2QENTRYTIMEFIELD
}
MaterialModule_pb.M2QENTRY_MSG.is_extendable = false
MaterialModule_pb.M2QENTRY_MSG.extensions = {}
MaterialModule_pb.M2QEntry = protobuf.Message(MaterialModule_pb.M2QENTRY_MSG)
MaterialModule_pb.MaterialChangePush = protobuf.Message(MaterialModule_pb.MATERIALCHANGEPUSH_MSG)
MaterialModule_pb.MaterialData = protobuf.Message(MaterialModule_pb.MATERIALDATA_MSG)

return MaterialModule_pb

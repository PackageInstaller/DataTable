-- chunkname: @modules/proto/EquipModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.EquipModule_pb", package.seeall)

local EquipModule_pb = {}

EquipModule_pb.EQUIPDELETEPUSH_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPLOCKREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPREFINEREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPBREAKREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.GETEQUIPINFOREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPLOCKREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPBREAKREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPUPDATEPUSH_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIP_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPEQUIPIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPLEVELFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPEXPFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPBREAKLVFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPCOUNTFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPISLOCKFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPREFINELVFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EATEQUIP_MSG = protobuf.Descriptor()
EquipModule_pb.EATEQUIPEATUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EATEQUIPCOUNTFIELD = protobuf.FieldDescriptor()
EquipModule_pb.GETEQUIPINFOREQUEST_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPREFINEREPLY_MSG = protobuf.Descriptor()
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD = protobuf.FieldDescriptor()
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.name = "uids"
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.full_name = ".EquipDeletePush.uids"
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.number = 1
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.index = 0
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.label = 3
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.default_value = {}
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.type = 3
EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD.cpp_type = 2
EquipModule_pb.EQUIPDELETEPUSH_MSG.name = "EquipDeletePush"
EquipModule_pb.EQUIPDELETEPUSH_MSG.full_name = ".EquipDeletePush"
EquipModule_pb.EQUIPDELETEPUSH_MSG.nested_types = {}
EquipModule_pb.EQUIPDELETEPUSH_MSG.enum_types = {}
EquipModule_pb.EQUIPDELETEPUSH_MSG.fields = {
	EquipModule_pb.EQUIPDELETEPUSHUIDSFIELD
}
EquipModule_pb.EQUIPDELETEPUSH_MSG.is_extendable = false
EquipModule_pb.EQUIPDELETEPUSH_MSG.extensions = {}
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.full_name = ".EquipLockRequest.targetUid"
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.name = "lock"
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.full_name = ".EquipLockRequest.lock"
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.number = 2
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.index = 1
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.label = 1
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.has_default_value = false
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.default_value = false
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.type = 8
EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD.cpp_type = 7
EquipModule_pb.EQUIPLOCKREQUEST_MSG.name = "EquipLockRequest"
EquipModule_pb.EQUIPLOCKREQUEST_MSG.full_name = ".EquipLockRequest"
EquipModule_pb.EQUIPLOCKREQUEST_MSG.nested_types = {}
EquipModule_pb.EQUIPLOCKREQUEST_MSG.enum_types = {}
EquipModule_pb.EQUIPLOCKREQUEST_MSG.fields = {
	EquipModule_pb.EQUIPLOCKREQUESTTARGETUIDFIELD,
	EquipModule_pb.EQUIPLOCKREQUESTLOCKFIELD
}
EquipModule_pb.EQUIPLOCKREQUEST_MSG.is_extendable = false
EquipModule_pb.EQUIPLOCKREQUEST_MSG.extensions = {}
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.full_name = ".EquipRefineRequest.targetUid"
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.name = "eatUids"
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.full_name = ".EquipRefineRequest.eatUids"
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.number = 2
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.index = 1
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.label = 3
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.default_value = {}
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.type = 3
EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD.cpp_type = 2
EquipModule_pb.EQUIPREFINEREQUEST_MSG.name = "EquipRefineRequest"
EquipModule_pb.EQUIPREFINEREQUEST_MSG.full_name = ".EquipRefineRequest"
EquipModule_pb.EQUIPREFINEREQUEST_MSG.nested_types = {}
EquipModule_pb.EQUIPREFINEREQUEST_MSG.enum_types = {}
EquipModule_pb.EQUIPREFINEREQUEST_MSG.fields = {
	EquipModule_pb.EQUIPREFINEREQUESTTARGETUIDFIELD,
	EquipModule_pb.EQUIPREFINEREQUESTEATUIDSFIELD
}
EquipModule_pb.EQUIPREFINEREQUEST_MSG.is_extendable = false
EquipModule_pb.EQUIPREFINEREQUEST_MSG.extensions = {}
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.name = "equipUids"
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.full_name = ".EquipDecomposeReply.equipUids"
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.number = 1
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.index = 0
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.label = 3
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.default_value = {}
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.type = 3
EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD.cpp_type = 2
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.name = "EquipDecomposeReply"
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.full_name = ".EquipDecomposeReply"
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.nested_types = {}
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.enum_types = {}
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.fields = {
	EquipModule_pb.EQUIPDECOMPOSEREPLYEQUIPUIDSFIELD
}
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.is_extendable = false
EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG.extensions = {}
EquipModule_pb.EQUIPBREAKREPLY_MSG.name = "EquipBreakReply"
EquipModule_pb.EQUIPBREAKREPLY_MSG.full_name = ".EquipBreakReply"
EquipModule_pb.EQUIPBREAKREPLY_MSG.nested_types = {}
EquipModule_pb.EQUIPBREAKREPLY_MSG.enum_types = {}
EquipModule_pb.EQUIPBREAKREPLY_MSG.fields = {}
EquipModule_pb.EQUIPBREAKREPLY_MSG.is_extendable = false
EquipModule_pb.EQUIPBREAKREPLY_MSG.extensions = {}
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.full_name = ".EquipStrengthenReply.targetUid"
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.name = "eatEquips"
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.full_name = ".EquipStrengthenReply.eatEquips"
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.number = 2
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.index = 1
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.label = 3
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.has_default_value = false
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.default_value = {}
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.message_type = EquipModule_pb.EATEQUIP_MSG
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.type = 11
EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD.cpp_type = 10
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.name = "EquipStrengthenReply"
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.full_name = ".EquipStrengthenReply"
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.nested_types = {}
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.enum_types = {}
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.fields = {
	EquipModule_pb.EQUIPSTRENGTHENREPLYTARGETUIDFIELD,
	EquipModule_pb.EQUIPSTRENGTHENREPLYEATEQUIPSFIELD
}
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.is_extendable = false
EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG.extensions = {}
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.name = "equipIds"
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.full_name = ".EquipComposeRequest.equipIds"
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.number = 1
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.index = 0
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.label = 3
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.default_value = {}
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.type = 5
EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD.cpp_type = 1
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.name = "EquipComposeRequest"
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.full_name = ".EquipComposeRequest"
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.nested_types = {}
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.enum_types = {}
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.fields = {
	EquipModule_pb.EQUIPCOMPOSEREQUESTEQUIPIDSFIELD
}
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.is_extendable = false
EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG.extensions = {}
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.name = "equips"
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.full_name = ".GetEquipInfoReply.equips"
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.number = 1
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.index = 0
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.label = 3
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.has_default_value = false
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.default_value = {}
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.message_type = EquipModule_pb.EQUIP_MSG
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.type = 11
EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD.cpp_type = 10
EquipModule_pb.GETEQUIPINFOREPLY_MSG.name = "GetEquipInfoReply"
EquipModule_pb.GETEQUIPINFOREPLY_MSG.full_name = ".GetEquipInfoReply"
EquipModule_pb.GETEQUIPINFOREPLY_MSG.nested_types = {}
EquipModule_pb.GETEQUIPINFOREPLY_MSG.enum_types = {}
EquipModule_pb.GETEQUIPINFOREPLY_MSG.fields = {
	EquipModule_pb.GETEQUIPINFOREPLYEQUIPSFIELD
}
EquipModule_pb.GETEQUIPINFOREPLY_MSG.is_extendable = false
EquipModule_pb.GETEQUIPINFOREPLY_MSG.extensions = {}
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.full_name = ".EquipLockReply.targetUid"
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.name = "lock"
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.full_name = ".EquipLockReply.lock"
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.number = 2
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.index = 1
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.label = 1
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.has_default_value = false
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.default_value = false
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.type = 8
EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD.cpp_type = 7
EquipModule_pb.EQUIPLOCKREPLY_MSG.name = "EquipLockReply"
EquipModule_pb.EQUIPLOCKREPLY_MSG.full_name = ".EquipLockReply"
EquipModule_pb.EQUIPLOCKREPLY_MSG.nested_types = {}
EquipModule_pb.EQUIPLOCKREPLY_MSG.enum_types = {}
EquipModule_pb.EQUIPLOCKREPLY_MSG.fields = {
	EquipModule_pb.EQUIPLOCKREPLYTARGETUIDFIELD,
	EquipModule_pb.EQUIPLOCKREPLYLOCKFIELD
}
EquipModule_pb.EQUIPLOCKREPLY_MSG.is_extendable = false
EquipModule_pb.EQUIPLOCKREPLY_MSG.extensions = {}
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.full_name = ".EquipBreakRequest.targetUid"
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPBREAKREQUEST_MSG.name = "EquipBreakRequest"
EquipModule_pb.EQUIPBREAKREQUEST_MSG.full_name = ".EquipBreakRequest"
EquipModule_pb.EQUIPBREAKREQUEST_MSG.nested_types = {}
EquipModule_pb.EQUIPBREAKREQUEST_MSG.enum_types = {}
EquipModule_pb.EQUIPBREAKREQUEST_MSG.fields = {
	EquipModule_pb.EQUIPBREAKREQUESTTARGETUIDFIELD
}
EquipModule_pb.EQUIPBREAKREQUEST_MSG.is_extendable = false
EquipModule_pb.EQUIPBREAKREQUEST_MSG.extensions = {}
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.name = "equips"
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.full_name = ".EquipUpdatePush.equips"
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.number = 1
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.index = 0
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.label = 3
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.has_default_value = false
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.default_value = {}
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.message_type = EquipModule_pb.EQUIP_MSG
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.type = 11
EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD.cpp_type = 10
EquipModule_pb.EQUIPUPDATEPUSH_MSG.name = "EquipUpdatePush"
EquipModule_pb.EQUIPUPDATEPUSH_MSG.full_name = ".EquipUpdatePush"
EquipModule_pb.EQUIPUPDATEPUSH_MSG.nested_types = {}
EquipModule_pb.EQUIPUPDATEPUSH_MSG.enum_types = {}
EquipModule_pb.EQUIPUPDATEPUSH_MSG.fields = {
	EquipModule_pb.EQUIPUPDATEPUSHEQUIPSFIELD
}
EquipModule_pb.EQUIPUPDATEPUSH_MSG.is_extendable = false
EquipModule_pb.EQUIPUPDATEPUSH_MSG.extensions = {}
EquipModule_pb.EQUIPEQUIPIDFIELD.name = "equipId"
EquipModule_pb.EQUIPEQUIPIDFIELD.full_name = ".Equip.equipId"
EquipModule_pb.EQUIPEQUIPIDFIELD.number = 1
EquipModule_pb.EQUIPEQUIPIDFIELD.index = 0
EquipModule_pb.EQUIPEQUIPIDFIELD.label = 1
EquipModule_pb.EQUIPEQUIPIDFIELD.has_default_value = false
EquipModule_pb.EQUIPEQUIPIDFIELD.default_value = 0
EquipModule_pb.EQUIPEQUIPIDFIELD.type = 5
EquipModule_pb.EQUIPEQUIPIDFIELD.cpp_type = 1
EquipModule_pb.EQUIPUIDFIELD.name = "uid"
EquipModule_pb.EQUIPUIDFIELD.full_name = ".Equip.uid"
EquipModule_pb.EQUIPUIDFIELD.number = 2
EquipModule_pb.EQUIPUIDFIELD.index = 1
EquipModule_pb.EQUIPUIDFIELD.label = 1
EquipModule_pb.EQUIPUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPUIDFIELD.default_value = 0
EquipModule_pb.EQUIPUIDFIELD.type = 3
EquipModule_pb.EQUIPUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPLEVELFIELD.name = "level"
EquipModule_pb.EQUIPLEVELFIELD.full_name = ".Equip.level"
EquipModule_pb.EQUIPLEVELFIELD.number = 3
EquipModule_pb.EQUIPLEVELFIELD.index = 2
EquipModule_pb.EQUIPLEVELFIELD.label = 1
EquipModule_pb.EQUIPLEVELFIELD.has_default_value = false
EquipModule_pb.EQUIPLEVELFIELD.default_value = 0
EquipModule_pb.EQUIPLEVELFIELD.type = 5
EquipModule_pb.EQUIPLEVELFIELD.cpp_type = 1
EquipModule_pb.EQUIPEXPFIELD.name = "exp"
EquipModule_pb.EQUIPEXPFIELD.full_name = ".Equip.exp"
EquipModule_pb.EQUIPEXPFIELD.number = 4
EquipModule_pb.EQUIPEXPFIELD.index = 3
EquipModule_pb.EQUIPEXPFIELD.label = 1
EquipModule_pb.EQUIPEXPFIELD.has_default_value = false
EquipModule_pb.EQUIPEXPFIELD.default_value = 0
EquipModule_pb.EQUIPEXPFIELD.type = 5
EquipModule_pb.EQUIPEXPFIELD.cpp_type = 1
EquipModule_pb.EQUIPBREAKLVFIELD.name = "breakLv"
EquipModule_pb.EQUIPBREAKLVFIELD.full_name = ".Equip.breakLv"
EquipModule_pb.EQUIPBREAKLVFIELD.number = 5
EquipModule_pb.EQUIPBREAKLVFIELD.index = 4
EquipModule_pb.EQUIPBREAKLVFIELD.label = 1
EquipModule_pb.EQUIPBREAKLVFIELD.has_default_value = false
EquipModule_pb.EQUIPBREAKLVFIELD.default_value = 0
EquipModule_pb.EQUIPBREAKLVFIELD.type = 5
EquipModule_pb.EQUIPBREAKLVFIELD.cpp_type = 1
EquipModule_pb.EQUIPCOUNTFIELD.name = "count"
EquipModule_pb.EQUIPCOUNTFIELD.full_name = ".Equip.count"
EquipModule_pb.EQUIPCOUNTFIELD.number = 7
EquipModule_pb.EQUIPCOUNTFIELD.index = 5
EquipModule_pb.EQUIPCOUNTFIELD.label = 1
EquipModule_pb.EQUIPCOUNTFIELD.has_default_value = false
EquipModule_pb.EQUIPCOUNTFIELD.default_value = 0
EquipModule_pb.EQUIPCOUNTFIELD.type = 5
EquipModule_pb.EQUIPCOUNTFIELD.cpp_type = 1
EquipModule_pb.EQUIPISLOCKFIELD.name = "isLock"
EquipModule_pb.EQUIPISLOCKFIELD.full_name = ".Equip.isLock"
EquipModule_pb.EQUIPISLOCKFIELD.number = 8
EquipModule_pb.EQUIPISLOCKFIELD.index = 6
EquipModule_pb.EQUIPISLOCKFIELD.label = 1
EquipModule_pb.EQUIPISLOCKFIELD.has_default_value = false
EquipModule_pb.EQUIPISLOCKFIELD.default_value = false
EquipModule_pb.EQUIPISLOCKFIELD.type = 8
EquipModule_pb.EQUIPISLOCKFIELD.cpp_type = 7
EquipModule_pb.EQUIPREFINELVFIELD.name = "refineLv"
EquipModule_pb.EQUIPREFINELVFIELD.full_name = ".Equip.refineLv"
EquipModule_pb.EQUIPREFINELVFIELD.number = 9
EquipModule_pb.EQUIPREFINELVFIELD.index = 7
EquipModule_pb.EQUIPREFINELVFIELD.label = 1
EquipModule_pb.EQUIPREFINELVFIELD.has_default_value = false
EquipModule_pb.EQUIPREFINELVFIELD.default_value = 0
EquipModule_pb.EQUIPREFINELVFIELD.type = 5
EquipModule_pb.EQUIPREFINELVFIELD.cpp_type = 1
EquipModule_pb.EQUIP_MSG.name = "Equip"
EquipModule_pb.EQUIP_MSG.full_name = ".Equip"
EquipModule_pb.EQUIP_MSG.nested_types = {}
EquipModule_pb.EQUIP_MSG.enum_types = {}
EquipModule_pb.EQUIP_MSG.fields = {
	EquipModule_pb.EQUIPEQUIPIDFIELD,
	EquipModule_pb.EQUIPUIDFIELD,
	EquipModule_pb.EQUIPLEVELFIELD,
	EquipModule_pb.EQUIPEXPFIELD,
	EquipModule_pb.EQUIPBREAKLVFIELD,
	EquipModule_pb.EQUIPCOUNTFIELD,
	EquipModule_pb.EQUIPISLOCKFIELD,
	EquipModule_pb.EQUIPREFINELVFIELD
}
EquipModule_pb.EQUIP_MSG.is_extendable = false
EquipModule_pb.EQUIP_MSG.extensions = {}
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.full_name = ".EquipStrengthenRequest.targetUid"
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.name = "eatEquips"
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.full_name = ".EquipStrengthenRequest.eatEquips"
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.number = 2
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.index = 1
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.label = 3
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.has_default_value = false
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.default_value = {}
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.message_type = EquipModule_pb.EATEQUIP_MSG
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.type = 11
EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD.cpp_type = 10
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.name = "EquipStrengthenRequest"
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.full_name = ".EquipStrengthenRequest"
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.nested_types = {}
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.enum_types = {}
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.fields = {
	EquipModule_pb.EQUIPSTRENGTHENREQUESTTARGETUIDFIELD,
	EquipModule_pb.EQUIPSTRENGTHENREQUESTEATEQUIPSFIELD
}
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.is_extendable = false
EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG.extensions = {}
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.name = "equipUids"
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.full_name = ".EquipDecomposeRequest.equipUids"
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.number = 1
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.index = 0
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.label = 3
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.default_value = {}
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.type = 3
EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD.cpp_type = 2
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.name = "EquipDecomposeRequest"
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.full_name = ".EquipDecomposeRequest"
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.nested_types = {}
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.enum_types = {}
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.fields = {
	EquipModule_pb.EQUIPDECOMPOSEREQUESTEQUIPUIDSFIELD
}
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.is_extendable = false
EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG.extensions = {}
EquipModule_pb.EATEQUIPEATUIDFIELD.name = "eatUid"
EquipModule_pb.EATEQUIPEATUIDFIELD.full_name = ".EatEquip.eatUid"
EquipModule_pb.EATEQUIPEATUIDFIELD.number = 1
EquipModule_pb.EATEQUIPEATUIDFIELD.index = 0
EquipModule_pb.EATEQUIPEATUIDFIELD.label = 1
EquipModule_pb.EATEQUIPEATUIDFIELD.has_default_value = false
EquipModule_pb.EATEQUIPEATUIDFIELD.default_value = 0
EquipModule_pb.EATEQUIPEATUIDFIELD.type = 3
EquipModule_pb.EATEQUIPEATUIDFIELD.cpp_type = 2
EquipModule_pb.EATEQUIPCOUNTFIELD.name = "count"
EquipModule_pb.EATEQUIPCOUNTFIELD.full_name = ".EatEquip.count"
EquipModule_pb.EATEQUIPCOUNTFIELD.number = 2
EquipModule_pb.EATEQUIPCOUNTFIELD.index = 1
EquipModule_pb.EATEQUIPCOUNTFIELD.label = 1
EquipModule_pb.EATEQUIPCOUNTFIELD.has_default_value = false
EquipModule_pb.EATEQUIPCOUNTFIELD.default_value = 0
EquipModule_pb.EATEQUIPCOUNTFIELD.type = 5
EquipModule_pb.EATEQUIPCOUNTFIELD.cpp_type = 1
EquipModule_pb.EATEQUIP_MSG.name = "EatEquip"
EquipModule_pb.EATEQUIP_MSG.full_name = ".EatEquip"
EquipModule_pb.EATEQUIP_MSG.nested_types = {}
EquipModule_pb.EATEQUIP_MSG.enum_types = {}
EquipModule_pb.EATEQUIP_MSG.fields = {
	EquipModule_pb.EATEQUIPEATUIDFIELD,
	EquipModule_pb.EATEQUIPCOUNTFIELD
}
EquipModule_pb.EATEQUIP_MSG.is_extendable = false
EquipModule_pb.EATEQUIP_MSG.extensions = {}
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.name = "GetEquipInfoRequest"
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.full_name = ".GetEquipInfoRequest"
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.nested_types = {}
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.enum_types = {}
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.fields = {}
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.is_extendable = false
EquipModule_pb.GETEQUIPINFOREQUEST_MSG.extensions = {}
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.name = "equipIds"
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.full_name = ".EquipComposeReply.equipIds"
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.number = 1
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.index = 0
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.label = 3
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.default_value = {}
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.type = 5
EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD.cpp_type = 1
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.name = "EquipComposeReply"
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.full_name = ".EquipComposeReply"
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.nested_types = {}
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.enum_types = {}
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.fields = {
	EquipModule_pb.EQUIPCOMPOSEREPLYEQUIPIDSFIELD
}
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.is_extendable = false
EquipModule_pb.EQUIPCOMPOSEREPLY_MSG.extensions = {}
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.name = "targetUid"
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.full_name = ".EquipRefineReply.targetUid"
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.number = 1
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.index = 0
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.label = 1
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.has_default_value = false
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.default_value = 0
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.type = 3
EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD.cpp_type = 2
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.name = "eatUids"
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.full_name = ".EquipRefineReply.eatUids"
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.number = 2
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.index = 1
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.label = 3
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.has_default_value = false
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.default_value = {}
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.type = 3
EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD.cpp_type = 2
EquipModule_pb.EQUIPREFINEREPLY_MSG.name = "EquipRefineReply"
EquipModule_pb.EQUIPREFINEREPLY_MSG.full_name = ".EquipRefineReply"
EquipModule_pb.EQUIPREFINEREPLY_MSG.nested_types = {}
EquipModule_pb.EQUIPREFINEREPLY_MSG.enum_types = {}
EquipModule_pb.EQUIPREFINEREPLY_MSG.fields = {
	EquipModule_pb.EQUIPREFINEREPLYTARGETUIDFIELD,
	EquipModule_pb.EQUIPREFINEREPLYEATUIDSFIELD
}
EquipModule_pb.EQUIPREFINEREPLY_MSG.is_extendable = false
EquipModule_pb.EQUIPREFINEREPLY_MSG.extensions = {}
EquipModule_pb.EatEquip = protobuf.Message(EquipModule_pb.EATEQUIP_MSG)
EquipModule_pb.Equip = protobuf.Message(EquipModule_pb.EQUIP_MSG)
EquipModule_pb.EquipBreakReply = protobuf.Message(EquipModule_pb.EQUIPBREAKREPLY_MSG)
EquipModule_pb.EquipBreakRequest = protobuf.Message(EquipModule_pb.EQUIPBREAKREQUEST_MSG)
EquipModule_pb.EquipComposeReply = protobuf.Message(EquipModule_pb.EQUIPCOMPOSEREPLY_MSG)
EquipModule_pb.EquipComposeRequest = protobuf.Message(EquipModule_pb.EQUIPCOMPOSEREQUEST_MSG)
EquipModule_pb.EquipDecomposeReply = protobuf.Message(EquipModule_pb.EQUIPDECOMPOSEREPLY_MSG)
EquipModule_pb.EquipDecomposeRequest = protobuf.Message(EquipModule_pb.EQUIPDECOMPOSEREQUEST_MSG)
EquipModule_pb.EquipDeletePush = protobuf.Message(EquipModule_pb.EQUIPDELETEPUSH_MSG)
EquipModule_pb.EquipLockReply = protobuf.Message(EquipModule_pb.EQUIPLOCKREPLY_MSG)
EquipModule_pb.EquipLockRequest = protobuf.Message(EquipModule_pb.EQUIPLOCKREQUEST_MSG)
EquipModule_pb.EquipRefineReply = protobuf.Message(EquipModule_pb.EQUIPREFINEREPLY_MSG)
EquipModule_pb.EquipRefineRequest = protobuf.Message(EquipModule_pb.EQUIPREFINEREQUEST_MSG)
EquipModule_pb.EquipStrengthenReply = protobuf.Message(EquipModule_pb.EQUIPSTRENGTHENREPLY_MSG)
EquipModule_pb.EquipStrengthenRequest = protobuf.Message(EquipModule_pb.EQUIPSTRENGTHENREQUEST_MSG)
EquipModule_pb.EquipUpdatePush = protobuf.Message(EquipModule_pb.EQUIPUPDATEPUSH_MSG)
EquipModule_pb.GetEquipInfoReply = protobuf.Message(EquipModule_pb.GETEQUIPINFOREPLY_MSG)
EquipModule_pb.GetEquipInfoRequest = protobuf.Message(EquipModule_pb.GETEQUIPINFOREQUEST_MSG)

return EquipModule_pb

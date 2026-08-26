-- chunkname: @modules/proto/TowerDeepModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.TowerDeepModule_pb", package.seeall)

local TowerDeepModule_pb = {}

TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPGROUP_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPTEAM_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPINFO_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPHERO_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG = protobuf.Descriptor()
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD = protobuf.FieldDescriptor()
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.name = "TowerDeepResetRequest"
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.full_name = ".TowerDeepResetRequest"
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.fields = {}
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.name = "group"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.full_name = ".TowerDeepFightSettlePush.group"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.message_type = TowerDeepModule_pb.TOWERDEEPGROUP_MSG
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.name = "result"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.full_name = ".TowerDeepFightSettlePush.result"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.number = 2
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.index = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.name = "highDeep"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.full_name = ".TowerDeepFightSettlePush.highDeep"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.number = 3
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.index = 2
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.name = "newRecord"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.full_name = ".TowerDeepFightSettlePush.newRecord"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.number = 4
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.index = 3
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.default_value = false
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.type = 8
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD.cpp_type = 7
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.name = "TowerDeepFightSettlePush"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.full_name = ".TowerDeepFightSettlePush"
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHGROUPFIELD,
	TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHRESULTFIELD,
	TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHHIGHDEEPFIELD,
	TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSHNEWRECORDFIELD
}
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.name = "teams"
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.full_name = ".TowerDeepGroup.teams"
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.label = 3
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.default_value = {}
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.message_type = TowerDeepModule_pb.TOWERDEEPTEAM_MSG
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.name = "currDeep"
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.full_name = ".TowerDeepGroup.currDeep"
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.number = 2
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.index = 1
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.name = "TowerDeepGroup"
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.full_name = ".TowerDeepGroup"
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPGROUPTEAMSFIELD,
	TowerDeepModule_pb.TOWERDEEPGROUPCURRDEEPFIELD
}
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPGROUP_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.name = "teamNo"
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.full_name = ".TowerDeepTeam.teamNo"
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.name = "heroes"
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.full_name = ".TowerDeepTeam.heroes"
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.number = 2
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.index = 1
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.label = 3
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.default_value = {}
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.message_type = TowerDeepModule_pb.TOWERDEEPHERO_MSG
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.name = "deep"
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.full_name = ".TowerDeepTeam.deep"
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.number = 3
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.index = 2
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.name = "TowerDeepTeam"
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.full_name = ".TowerDeepTeam"
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPTEAMTEAMNOFIELD,
	TowerDeepModule_pb.TOWERDEEPTEAMHEROESFIELD,
	TowerDeepModule_pb.TOWERDEEPTEAMDEEPFIELD
}
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPTEAM_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.name = "archive"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.full_name = ".TowerDeepSaveArchiveReply.archive"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.message_type = TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.name = "TowerDeepSaveArchiveReply"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.full_name = ".TowerDeepSaveArchiveReply"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLYARCHIVEFIELD
}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.name = "TowerDeepGetInfoRequest"
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.full_name = ".TowerDeepGetInfoRequest"
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.fields = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.name = "archiveNo"
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.full_name = ".TowerDeepArchive.archiveNo"
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.name = "group"
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.full_name = ".TowerDeepArchive.group"
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.number = 2
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.index = 1
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.message_type = TowerDeepModule_pb.TOWERDEEPGROUP_MSG
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.name = "createTime"
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.full_name = ".TowerDeepArchive.createTime"
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.number = 3
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.index = 2
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.type = 3
TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD.cpp_type = 2
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.name = "TowerDeepArchive"
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.full_name = ".TowerDeepArchive"
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPARCHIVEARCHIVENOFIELD,
	TowerDeepModule_pb.TOWERDEEPARCHIVEGROUPFIELD,
	TowerDeepModule_pb.TOWERDEEPARCHIVECREATETIMEFIELD
}
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.name = "group"
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.full_name = ".TowerDeepInfo.group"
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.message_type = TowerDeepModule_pb.TOWERDEEPGROUP_MSG
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.name = "endless"
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.full_name = ".TowerDeepInfo.endless"
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.number = 2
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.index = 1
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.default_value = false
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.type = 8
TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD.cpp_type = 7
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.name = "archives"
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.full_name = ".TowerDeepInfo.archives"
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.number = 3
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.index = 2
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.label = 3
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.default_value = {}
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.message_type = TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.name = "highDeep"
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.full_name = ".TowerDeepInfo.highDeep"
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.number = 4
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.index = 3
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPINFO_MSG.name = "TowerDeepInfo"
TowerDeepModule_pb.TOWERDEEPINFO_MSG.full_name = ".TowerDeepInfo"
TowerDeepModule_pb.TOWERDEEPINFO_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPINFO_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPINFO_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPINFOGROUPFIELD,
	TowerDeepModule_pb.TOWERDEEPINFOENDLESSFIELD,
	TowerDeepModule_pb.TOWERDEEPINFOARCHIVESFIELD,
	TowerDeepModule_pb.TOWERDEEPINFOHIGHDEEPFIELD
}
TowerDeepModule_pb.TOWERDEEPINFO_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPINFO_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.name = "info"
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.full_name = ".TowerDeepGetInfoReply.info"
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.message_type = TowerDeepModule_pb.TOWERDEEPINFO_MSG
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.name = "TowerDeepGetInfoReply"
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.full_name = ".TowerDeepGetInfoReply"
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPGETINFOREPLYINFOFIELD
}
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.name = "archiveNo"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.full_name = ".TowerDeepLoadArchiveRequest.archiveNo"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.name = "TowerDeepLoadArchiveRequest"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.full_name = ".TowerDeepLoadArchiveRequest"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUESTARCHIVENOFIELD
}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.name = "group"
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.full_name = ".TowerDeepResetReply.group"
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.message_type = TowerDeepModule_pb.TOWERDEEPGROUP_MSG
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.name = "TowerDeepResetReply"
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.full_name = ".TowerDeepResetReply"
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPRESETREPLYGROUPFIELD
}
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.name = "archive"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.full_name = ".TowerDeepLoadArchiveReply.archive"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.default_value = nil
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.message_type = TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.type = 11
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD.cpp_type = 10
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.name = "TowerDeepLoadArchiveReply"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.full_name = ".TowerDeepLoadArchiveReply"
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLYARCHIVEFIELD
}
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.name = "heroId"
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.full_name = ".TowerDeepHero.heroId"
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.name = "trialId"
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.full_name = ".TowerDeepHero.trialId"
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.number = 2
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.index = 1
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPHERO_MSG.name = "TowerDeepHero"
TowerDeepModule_pb.TOWERDEEPHERO_MSG.full_name = ".TowerDeepHero"
TowerDeepModule_pb.TOWERDEEPHERO_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPHERO_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPHERO_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPHEROHEROIDFIELD,
	TowerDeepModule_pb.TOWERDEEPHEROTRIALIDFIELD
}
TowerDeepModule_pb.TOWERDEEPHERO_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPHERO_MSG.extensions = {}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.name = "archiveNo"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.full_name = ".TowerDeepSaveArchiveRequest.archiveNo"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.number = 1
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.index = 0
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.label = 1
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.has_default_value = false
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.default_value = 0
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.type = 5
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD.cpp_type = 1
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.name = "TowerDeepSaveArchiveRequest"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.full_name = ".TowerDeepSaveArchiveRequest"
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.nested_types = {}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.enum_types = {}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.fields = {
	TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUESTARCHIVENOFIELD
}
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.is_extendable = false
TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG.extensions = {}
TowerDeepModule_pb.TowerDeepArchive = protobuf.Message(TowerDeepModule_pb.TOWERDEEPARCHIVE_MSG)
TowerDeepModule_pb.TowerDeepFightSettlePush = protobuf.Message(TowerDeepModule_pb.TOWERDEEPFIGHTSETTLEPUSH_MSG)
TowerDeepModule_pb.TowerDeepGetInfoReply = protobuf.Message(TowerDeepModule_pb.TOWERDEEPGETINFOREPLY_MSG)
TowerDeepModule_pb.TowerDeepGetInfoRequest = protobuf.Message(TowerDeepModule_pb.TOWERDEEPGETINFOREQUEST_MSG)
TowerDeepModule_pb.TowerDeepGroup = protobuf.Message(TowerDeepModule_pb.TOWERDEEPGROUP_MSG)
TowerDeepModule_pb.TowerDeepHero = protobuf.Message(TowerDeepModule_pb.TOWERDEEPHERO_MSG)
TowerDeepModule_pb.TowerDeepInfo = protobuf.Message(TowerDeepModule_pb.TOWERDEEPINFO_MSG)
TowerDeepModule_pb.TowerDeepLoadArchiveReply = protobuf.Message(TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREPLY_MSG)
TowerDeepModule_pb.TowerDeepLoadArchiveRequest = protobuf.Message(TowerDeepModule_pb.TOWERDEEPLOADARCHIVEREQUEST_MSG)
TowerDeepModule_pb.TowerDeepResetReply = protobuf.Message(TowerDeepModule_pb.TOWERDEEPRESETREPLY_MSG)
TowerDeepModule_pb.TowerDeepResetRequest = protobuf.Message(TowerDeepModule_pb.TOWERDEEPRESETREQUEST_MSG)
TowerDeepModule_pb.TowerDeepSaveArchiveReply = protobuf.Message(TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREPLY_MSG)
TowerDeepModule_pb.TowerDeepSaveArchiveRequest = protobuf.Message(TowerDeepModule_pb.TOWERDEEPSAVEARCHIVEREQUEST_MSG)
TowerDeepModule_pb.TowerDeepTeam = protobuf.Message(TowerDeepModule_pb.TOWERDEEPTEAM_MSG)

return TowerDeepModule_pb

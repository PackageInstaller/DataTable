-- chunkname: @modules/proto/TowerDef_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.TowerDef_pb", package.seeall)

local TowerDef_pb = {}

TowerDef_pb.EPISODENO_MSG = protobuf.Descriptor()
TowerDef_pb.EPISODENOEPISODEIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.EPISODENOSTATUSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.EPISODENOHEROSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TALENTPLANNO_MSG = protobuf.Descriptor()
TowerDef_pb.TALENTPLANNOPLANIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD = protobuf.FieldDescriptor()
TowerDef_pb.ASSISTBOSSNO_MSG = protobuf.Descriptor()
TowerDef_pb.ASSISTBOSSNOIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.ASSISTBOSSNOLEVELFIELD = protobuf.FieldDescriptor()
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD = protobuf.FieldDescriptor()
TowerDef_pb.LAYERNO_MSG = protobuf.Descriptor()
TowerDef_pb.LAYERNOLAYERIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD = protobuf.FieldDescriptor()
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD = protobuf.FieldDescriptor()
TowerDef_pb.LAYERNOEPISODENOSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.HERONO_MSG = protobuf.Descriptor()
TowerDef_pb.HERONOHEROIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.HERONOEQUIPUIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.HERONOTRIALIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNO_MSG = protobuf.Descriptor()
TowerDef_pb.TOWERNOTYPEFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOTOWERIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOPASSLAYERIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOLAYERNOSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOPARAMSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNO_MSG = protobuf.Descriptor()
TowerDef_pb.TOWEROPENNOTYPEFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNOTOWERIDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNOSTATUSFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNOROUNDFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD = protobuf.FieldDescriptor()
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD = protobuf.FieldDescriptor()
TowerDef_pb.EPISODENOEPISODEIDFIELD.name = "episodeId"
TowerDef_pb.EPISODENOEPISODEIDFIELD.full_name = ".EpisodeNO.episodeId"
TowerDef_pb.EPISODENOEPISODEIDFIELD.number = 1
TowerDef_pb.EPISODENOEPISODEIDFIELD.index = 0
TowerDef_pb.EPISODENOEPISODEIDFIELD.label = 1
TowerDef_pb.EPISODENOEPISODEIDFIELD.has_default_value = false
TowerDef_pb.EPISODENOEPISODEIDFIELD.default_value = 0
TowerDef_pb.EPISODENOEPISODEIDFIELD.type = 5
TowerDef_pb.EPISODENOEPISODEIDFIELD.cpp_type = 1
TowerDef_pb.EPISODENOSTATUSFIELD.name = "status"
TowerDef_pb.EPISODENOSTATUSFIELD.full_name = ".EpisodeNO.status"
TowerDef_pb.EPISODENOSTATUSFIELD.number = 2
TowerDef_pb.EPISODENOSTATUSFIELD.index = 1
TowerDef_pb.EPISODENOSTATUSFIELD.label = 1
TowerDef_pb.EPISODENOSTATUSFIELD.has_default_value = false
TowerDef_pb.EPISODENOSTATUSFIELD.default_value = 0
TowerDef_pb.EPISODENOSTATUSFIELD.type = 5
TowerDef_pb.EPISODENOSTATUSFIELD.cpp_type = 1
TowerDef_pb.EPISODENOHEROSFIELD.name = "heros"
TowerDef_pb.EPISODENOHEROSFIELD.full_name = ".EpisodeNO.heros"
TowerDef_pb.EPISODENOHEROSFIELD.number = 3
TowerDef_pb.EPISODENOHEROSFIELD.index = 2
TowerDef_pb.EPISODENOHEROSFIELD.label = 3
TowerDef_pb.EPISODENOHEROSFIELD.has_default_value = false
TowerDef_pb.EPISODENOHEROSFIELD.default_value = {}
TowerDef_pb.EPISODENOHEROSFIELD.message_type = TowerDef_pb.HERONO_MSG
TowerDef_pb.EPISODENOHEROSFIELD.type = 11
TowerDef_pb.EPISODENOHEROSFIELD.cpp_type = 10
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.name = "assistBossId"
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.full_name = ".EpisodeNO.assistBossId"
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.number = 4
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.index = 3
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.label = 1
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.has_default_value = false
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.default_value = 0
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.type = 5
TowerDef_pb.EPISODENOASSISTBOSSIDFIELD.cpp_type = 1
TowerDef_pb.EPISODENO_MSG.name = "EpisodeNO"
TowerDef_pb.EPISODENO_MSG.full_name = ".EpisodeNO"
TowerDef_pb.EPISODENO_MSG.nested_types = {}
TowerDef_pb.EPISODENO_MSG.enum_types = {}
TowerDef_pb.EPISODENO_MSG.fields = {
	TowerDef_pb.EPISODENOEPISODEIDFIELD,
	TowerDef_pb.EPISODENOSTATUSFIELD,
	TowerDef_pb.EPISODENOHEROSFIELD,
	TowerDef_pb.EPISODENOASSISTBOSSIDFIELD
}
TowerDef_pb.EPISODENO_MSG.is_extendable = false
TowerDef_pb.EPISODENO_MSG.extensions = {}
TowerDef_pb.TALENTPLANNOPLANIDFIELD.name = "planId"
TowerDef_pb.TALENTPLANNOPLANIDFIELD.full_name = ".TalentPlanNO.planId"
TowerDef_pb.TALENTPLANNOPLANIDFIELD.number = 1
TowerDef_pb.TALENTPLANNOPLANIDFIELD.index = 0
TowerDef_pb.TALENTPLANNOPLANIDFIELD.label = 1
TowerDef_pb.TALENTPLANNOPLANIDFIELD.has_default_value = false
TowerDef_pb.TALENTPLANNOPLANIDFIELD.default_value = 0
TowerDef_pb.TALENTPLANNOPLANIDFIELD.type = 5
TowerDef_pb.TALENTPLANNOPLANIDFIELD.cpp_type = 1
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.name = "talentPoint"
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.full_name = ".TalentPlanNO.talentPoint"
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.number = 2
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.index = 1
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.label = 1
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.has_default_value = false
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.default_value = 0
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.type = 5
TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD.cpp_type = 1
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.name = "talentIds"
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.full_name = ".TalentPlanNO.talentIds"
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.number = 3
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.index = 2
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.label = 3
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.has_default_value = false
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.default_value = {}
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.type = 5
TowerDef_pb.TALENTPLANNOTALENTIDSFIELD.cpp_type = 1
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.name = "planName"
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.full_name = ".TalentPlanNO.planName"
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.number = 4
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.index = 3
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.label = 1
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.has_default_value = false
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.default_value = ""
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.type = 9
TowerDef_pb.TALENTPLANNOPLANNAMEFIELD.cpp_type = 9
TowerDef_pb.TALENTPLANNO_MSG.name = "TalentPlanNO"
TowerDef_pb.TALENTPLANNO_MSG.full_name = ".TalentPlanNO"
TowerDef_pb.TALENTPLANNO_MSG.nested_types = {}
TowerDef_pb.TALENTPLANNO_MSG.enum_types = {}
TowerDef_pb.TALENTPLANNO_MSG.fields = {
	TowerDef_pb.TALENTPLANNOPLANIDFIELD,
	TowerDef_pb.TALENTPLANNOTALENTPOINTFIELD,
	TowerDef_pb.TALENTPLANNOTALENTIDSFIELD,
	TowerDef_pb.TALENTPLANNOPLANNAMEFIELD
}
TowerDef_pb.TALENTPLANNO_MSG.is_extendable = false
TowerDef_pb.TALENTPLANNO_MSG.extensions = {}
TowerDef_pb.ASSISTBOSSNOIDFIELD.name = "id"
TowerDef_pb.ASSISTBOSSNOIDFIELD.full_name = ".AssistBossNO.id"
TowerDef_pb.ASSISTBOSSNOIDFIELD.number = 1
TowerDef_pb.ASSISTBOSSNOIDFIELD.index = 0
TowerDef_pb.ASSISTBOSSNOIDFIELD.label = 1
TowerDef_pb.ASSISTBOSSNOIDFIELD.has_default_value = false
TowerDef_pb.ASSISTBOSSNOIDFIELD.default_value = 0
TowerDef_pb.ASSISTBOSSNOIDFIELD.type = 5
TowerDef_pb.ASSISTBOSSNOIDFIELD.cpp_type = 1
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.name = "level"
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.full_name = ".AssistBossNO.level"
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.number = 2
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.index = 1
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.label = 1
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.has_default_value = false
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.default_value = 0
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.type = 5
TowerDef_pb.ASSISTBOSSNOLEVELFIELD.cpp_type = 1
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.name = "talentPlans"
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.full_name = ".AssistBossNO.talentPlans"
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.number = 3
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.index = 2
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.label = 3
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.has_default_value = false
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.default_value = {}
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.message_type = TowerDef_pb.TALENTPLANNO_MSG
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.type = 11
TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD.cpp_type = 10
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.name = "useTalentPlan"
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.full_name = ".AssistBossNO.useTalentPlan"
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.number = 4
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.index = 3
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.label = 1
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.has_default_value = false
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.default_value = 0
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.type = 5
TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD.cpp_type = 1
TowerDef_pb.ASSISTBOSSNO_MSG.name = "AssistBossNO"
TowerDef_pb.ASSISTBOSSNO_MSG.full_name = ".AssistBossNO"
TowerDef_pb.ASSISTBOSSNO_MSG.nested_types = {}
TowerDef_pb.ASSISTBOSSNO_MSG.enum_types = {}
TowerDef_pb.ASSISTBOSSNO_MSG.fields = {
	TowerDef_pb.ASSISTBOSSNOIDFIELD,
	TowerDef_pb.ASSISTBOSSNOLEVELFIELD,
	TowerDef_pb.ASSISTBOSSNOTALENTPLANSFIELD,
	TowerDef_pb.ASSISTBOSSNOUSETALENTPLANFIELD
}
TowerDef_pb.ASSISTBOSSNO_MSG.is_extendable = false
TowerDef_pb.ASSISTBOSSNO_MSG.extensions = {}
TowerDef_pb.LAYERNOLAYERIDFIELD.name = "layerId"
TowerDef_pb.LAYERNOLAYERIDFIELD.full_name = ".LayerNO.layerId"
TowerDef_pb.LAYERNOLAYERIDFIELD.number = 1
TowerDef_pb.LAYERNOLAYERIDFIELD.index = 0
TowerDef_pb.LAYERNOLAYERIDFIELD.label = 1
TowerDef_pb.LAYERNOLAYERIDFIELD.has_default_value = false
TowerDef_pb.LAYERNOLAYERIDFIELD.default_value = 0
TowerDef_pb.LAYERNOLAYERIDFIELD.type = 5
TowerDef_pb.LAYERNOLAYERIDFIELD.cpp_type = 1
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.name = "currHighScore"
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.full_name = ".LayerNO.currHighScore"
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.number = 2
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.index = 1
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.label = 1
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.has_default_value = false
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.default_value = 0
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.type = 5
TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD.cpp_type = 1
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.name = "historyHighScore"
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.full_name = ".LayerNO.historyHighScore"
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.number = 3
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.index = 2
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.label = 1
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.has_default_value = false
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.default_value = 0
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.type = 5
TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD.cpp_type = 1
TowerDef_pb.LAYERNOEPISODENOSFIELD.name = "episodeNOs"
TowerDef_pb.LAYERNOEPISODENOSFIELD.full_name = ".LayerNO.episodeNOs"
TowerDef_pb.LAYERNOEPISODENOSFIELD.number = 4
TowerDef_pb.LAYERNOEPISODENOSFIELD.index = 3
TowerDef_pb.LAYERNOEPISODENOSFIELD.label = 3
TowerDef_pb.LAYERNOEPISODENOSFIELD.has_default_value = false
TowerDef_pb.LAYERNOEPISODENOSFIELD.default_value = {}
TowerDef_pb.LAYERNOEPISODENOSFIELD.message_type = TowerDef_pb.EPISODENO_MSG
TowerDef_pb.LAYERNOEPISODENOSFIELD.type = 11
TowerDef_pb.LAYERNOEPISODENOSFIELD.cpp_type = 10
TowerDef_pb.LAYERNO_MSG.name = "LayerNO"
TowerDef_pb.LAYERNO_MSG.full_name = ".LayerNO"
TowerDef_pb.LAYERNO_MSG.nested_types = {}
TowerDef_pb.LAYERNO_MSG.enum_types = {}
TowerDef_pb.LAYERNO_MSG.fields = {
	TowerDef_pb.LAYERNOLAYERIDFIELD,
	TowerDef_pb.LAYERNOCURRHIGHSCOREFIELD,
	TowerDef_pb.LAYERNOHISTORYHIGHSCOREFIELD,
	TowerDef_pb.LAYERNOEPISODENOSFIELD
}
TowerDef_pb.LAYERNO_MSG.is_extendable = false
TowerDef_pb.LAYERNO_MSG.extensions = {}
TowerDef_pb.HERONOHEROIDFIELD.name = "heroId"
TowerDef_pb.HERONOHEROIDFIELD.full_name = ".HeroNO.heroId"
TowerDef_pb.HERONOHEROIDFIELD.number = 1
TowerDef_pb.HERONOHEROIDFIELD.index = 0
TowerDef_pb.HERONOHEROIDFIELD.label = 1
TowerDef_pb.HERONOHEROIDFIELD.has_default_value = false
TowerDef_pb.HERONOHEROIDFIELD.default_value = 0
TowerDef_pb.HERONOHEROIDFIELD.type = 5
TowerDef_pb.HERONOHEROIDFIELD.cpp_type = 1
TowerDef_pb.HERONOEQUIPUIDFIELD.name = "equipUid"
TowerDef_pb.HERONOEQUIPUIDFIELD.full_name = ".HeroNO.equipUid"
TowerDef_pb.HERONOEQUIPUIDFIELD.number = 2
TowerDef_pb.HERONOEQUIPUIDFIELD.index = 1
TowerDef_pb.HERONOEQUIPUIDFIELD.label = 3
TowerDef_pb.HERONOEQUIPUIDFIELD.has_default_value = false
TowerDef_pb.HERONOEQUIPUIDFIELD.default_value = {}
TowerDef_pb.HERONOEQUIPUIDFIELD.type = 3
TowerDef_pb.HERONOEQUIPUIDFIELD.cpp_type = 2
TowerDef_pb.HERONOTRIALIDFIELD.name = "trialId"
TowerDef_pb.HERONOTRIALIDFIELD.full_name = ".HeroNO.trialId"
TowerDef_pb.HERONOTRIALIDFIELD.number = 3
TowerDef_pb.HERONOTRIALIDFIELD.index = 2
TowerDef_pb.HERONOTRIALIDFIELD.label = 1
TowerDef_pb.HERONOTRIALIDFIELD.has_default_value = false
TowerDef_pb.HERONOTRIALIDFIELD.default_value = 0
TowerDef_pb.HERONOTRIALIDFIELD.type = 5
TowerDef_pb.HERONOTRIALIDFIELD.cpp_type = 1
TowerDef_pb.HERONO_MSG.name = "HeroNO"
TowerDef_pb.HERONO_MSG.full_name = ".HeroNO"
TowerDef_pb.HERONO_MSG.nested_types = {}
TowerDef_pb.HERONO_MSG.enum_types = {}
TowerDef_pb.HERONO_MSG.fields = {
	TowerDef_pb.HERONOHEROIDFIELD,
	TowerDef_pb.HERONOEQUIPUIDFIELD,
	TowerDef_pb.HERONOTRIALIDFIELD
}
TowerDef_pb.HERONO_MSG.is_extendable = false
TowerDef_pb.HERONO_MSG.extensions = {}
TowerDef_pb.TOWERNOTYPEFIELD.name = "type"
TowerDef_pb.TOWERNOTYPEFIELD.full_name = ".TowerNO.type"
TowerDef_pb.TOWERNOTYPEFIELD.number = 1
TowerDef_pb.TOWERNOTYPEFIELD.index = 0
TowerDef_pb.TOWERNOTYPEFIELD.label = 1
TowerDef_pb.TOWERNOTYPEFIELD.has_default_value = false
TowerDef_pb.TOWERNOTYPEFIELD.default_value = 0
TowerDef_pb.TOWERNOTYPEFIELD.type = 5
TowerDef_pb.TOWERNOTYPEFIELD.cpp_type = 1
TowerDef_pb.TOWERNOTOWERIDFIELD.name = "towerId"
TowerDef_pb.TOWERNOTOWERIDFIELD.full_name = ".TowerNO.towerId"
TowerDef_pb.TOWERNOTOWERIDFIELD.number = 2
TowerDef_pb.TOWERNOTOWERIDFIELD.index = 1
TowerDef_pb.TOWERNOTOWERIDFIELD.label = 1
TowerDef_pb.TOWERNOTOWERIDFIELD.has_default_value = false
TowerDef_pb.TOWERNOTOWERIDFIELD.default_value = 0
TowerDef_pb.TOWERNOTOWERIDFIELD.type = 5
TowerDef_pb.TOWERNOTOWERIDFIELD.cpp_type = 1
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.name = "passLayerId"
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.full_name = ".TowerNO.passLayerId"
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.number = 3
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.index = 2
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.label = 1
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.has_default_value = false
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.default_value = 0
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.type = 5
TowerDef_pb.TOWERNOPASSLAYERIDFIELD.cpp_type = 1
TowerDef_pb.TOWERNOLAYERNOSFIELD.name = "layerNOs"
TowerDef_pb.TOWERNOLAYERNOSFIELD.full_name = ".TowerNO.layerNOs"
TowerDef_pb.TOWERNOLAYERNOSFIELD.number = 4
TowerDef_pb.TOWERNOLAYERNOSFIELD.index = 3
TowerDef_pb.TOWERNOLAYERNOSFIELD.label = 3
TowerDef_pb.TOWERNOLAYERNOSFIELD.has_default_value = false
TowerDef_pb.TOWERNOLAYERNOSFIELD.default_value = {}
TowerDef_pb.TOWERNOLAYERNOSFIELD.message_type = TowerDef_pb.LAYERNO_MSG
TowerDef_pb.TOWERNOLAYERNOSFIELD.type = 11
TowerDef_pb.TOWERNOLAYERNOSFIELD.cpp_type = 10
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.name = "openSpLayerIds"
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.full_name = ".TowerNO.openSpLayerIds"
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.number = 5
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.index = 4
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.label = 3
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.has_default_value = false
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.default_value = {}
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.type = 5
TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD.cpp_type = 1
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.name = "historyHighScore"
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.full_name = ".TowerNO.historyHighScore"
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.number = 6
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.index = 5
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.label = 1
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.has_default_value = false
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.default_value = 0
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.type = 5
TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD.cpp_type = 1
TowerDef_pb.TOWERNOPARAMSFIELD.name = "params"
TowerDef_pb.TOWERNOPARAMSFIELD.full_name = ".TowerNO.params"
TowerDef_pb.TOWERNOPARAMSFIELD.number = 7
TowerDef_pb.TOWERNOPARAMSFIELD.index = 6
TowerDef_pb.TOWERNOPARAMSFIELD.label = 1
TowerDef_pb.TOWERNOPARAMSFIELD.has_default_value = false
TowerDef_pb.TOWERNOPARAMSFIELD.default_value = ""
TowerDef_pb.TOWERNOPARAMSFIELD.type = 9
TowerDef_pb.TOWERNOPARAMSFIELD.cpp_type = 9
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.name = "passTeachIds"
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.full_name = ".TowerNO.passTeachIds"
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.number = 8
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.index = 7
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.label = 3
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.has_default_value = false
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.default_value = {}
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.type = 5
TowerDef_pb.TOWERNOPASSTEACHIDSFIELD.cpp_type = 1
TowerDef_pb.TOWERNO_MSG.name = "TowerNO"
TowerDef_pb.TOWERNO_MSG.full_name = ".TowerNO"
TowerDef_pb.TOWERNO_MSG.nested_types = {}
TowerDef_pb.TOWERNO_MSG.enum_types = {}
TowerDef_pb.TOWERNO_MSG.fields = {
	TowerDef_pb.TOWERNOTYPEFIELD,
	TowerDef_pb.TOWERNOTOWERIDFIELD,
	TowerDef_pb.TOWERNOPASSLAYERIDFIELD,
	TowerDef_pb.TOWERNOLAYERNOSFIELD,
	TowerDef_pb.TOWERNOOPENSPLAYERIDSFIELD,
	TowerDef_pb.TOWERNOHISTORYHIGHSCOREFIELD,
	TowerDef_pb.TOWERNOPARAMSFIELD,
	TowerDef_pb.TOWERNOPASSTEACHIDSFIELD
}
TowerDef_pb.TOWERNO_MSG.is_extendable = false
TowerDef_pb.TOWERNO_MSG.extensions = {}
TowerDef_pb.TOWEROPENNOTYPEFIELD.name = "type"
TowerDef_pb.TOWEROPENNOTYPEFIELD.full_name = ".TowerOpenNO.type"
TowerDef_pb.TOWEROPENNOTYPEFIELD.number = 1
TowerDef_pb.TOWEROPENNOTYPEFIELD.index = 0
TowerDef_pb.TOWEROPENNOTYPEFIELD.label = 1
TowerDef_pb.TOWEROPENNOTYPEFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNOTYPEFIELD.default_value = 0
TowerDef_pb.TOWEROPENNOTYPEFIELD.type = 5
TowerDef_pb.TOWEROPENNOTYPEFIELD.cpp_type = 1
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.name = "towerId"
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.full_name = ".TowerOpenNO.towerId"
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.number = 2
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.index = 1
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.label = 1
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.default_value = 0
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.type = 5
TowerDef_pb.TOWEROPENNOTOWERIDFIELD.cpp_type = 1
TowerDef_pb.TOWEROPENNOSTATUSFIELD.name = "status"
TowerDef_pb.TOWEROPENNOSTATUSFIELD.full_name = ".TowerOpenNO.status"
TowerDef_pb.TOWEROPENNOSTATUSFIELD.number = 3
TowerDef_pb.TOWEROPENNOSTATUSFIELD.index = 2
TowerDef_pb.TOWEROPENNOSTATUSFIELD.label = 1
TowerDef_pb.TOWEROPENNOSTATUSFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNOSTATUSFIELD.default_value = 0
TowerDef_pb.TOWEROPENNOSTATUSFIELD.type = 5
TowerDef_pb.TOWEROPENNOSTATUSFIELD.cpp_type = 1
TowerDef_pb.TOWEROPENNOROUNDFIELD.name = "round"
TowerDef_pb.TOWEROPENNOROUNDFIELD.full_name = ".TowerOpenNO.round"
TowerDef_pb.TOWEROPENNOROUNDFIELD.number = 4
TowerDef_pb.TOWEROPENNOROUNDFIELD.index = 3
TowerDef_pb.TOWEROPENNOROUNDFIELD.label = 1
TowerDef_pb.TOWEROPENNOROUNDFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNOROUNDFIELD.default_value = 0
TowerDef_pb.TOWEROPENNOROUNDFIELD.type = 5
TowerDef_pb.TOWEROPENNOROUNDFIELD.cpp_type = 1
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.name = "nextTime"
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.full_name = ".TowerOpenNO.nextTime"
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.number = 5
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.index = 4
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.label = 1
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.default_value = 0
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.type = 3
TowerDef_pb.TOWEROPENNONEXTTIMEFIELD.cpp_type = 2
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.name = "towerStartTime"
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.full_name = ".TowerOpenNO.towerStartTime"
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.number = 6
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.index = 5
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.label = 1
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.default_value = 0
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.type = 3
TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD.cpp_type = 2
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.name = "taskEndTime"
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.full_name = ".TowerOpenNO.taskEndTime"
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.number = 7
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.index = 6
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.label = 1
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.has_default_value = false
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.default_value = 0
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.type = 3
TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD.cpp_type = 2
TowerDef_pb.TOWEROPENNO_MSG.name = "TowerOpenNO"
TowerDef_pb.TOWEROPENNO_MSG.full_name = ".TowerOpenNO"
TowerDef_pb.TOWEROPENNO_MSG.nested_types = {}
TowerDef_pb.TOWEROPENNO_MSG.enum_types = {}
TowerDef_pb.TOWEROPENNO_MSG.fields = {
	TowerDef_pb.TOWEROPENNOTYPEFIELD,
	TowerDef_pb.TOWEROPENNOTOWERIDFIELD,
	TowerDef_pb.TOWEROPENNOSTATUSFIELD,
	TowerDef_pb.TOWEROPENNOROUNDFIELD,
	TowerDef_pb.TOWEROPENNONEXTTIMEFIELD,
	TowerDef_pb.TOWEROPENNOTOWERSTARTTIMEFIELD,
	TowerDef_pb.TOWEROPENNOTASKENDTIMEFIELD
}
TowerDef_pb.TOWEROPENNO_MSG.is_extendable = false
TowerDef_pb.TOWEROPENNO_MSG.extensions = {}
TowerDef_pb.AssistBossNO = protobuf.Message(TowerDef_pb.ASSISTBOSSNO_MSG)
TowerDef_pb.EpisodeNO = protobuf.Message(TowerDef_pb.EPISODENO_MSG)
TowerDef_pb.HeroNO = protobuf.Message(TowerDef_pb.HERONO_MSG)
TowerDef_pb.LayerNO = protobuf.Message(TowerDef_pb.LAYERNO_MSG)
TowerDef_pb.TalentPlanNO = protobuf.Message(TowerDef_pb.TALENTPLANNO_MSG)
TowerDef_pb.TowerNO = protobuf.Message(TowerDef_pb.TOWERNO_MSG)
TowerDef_pb.TowerOpenNO = protobuf.Message(TowerDef_pb.TOWEROPENNO_MSG)

return TowerDef_pb

local UIBossraid = {
    Name = UIWindowNames.UIBossraid,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIBossraid.Model.UIBossraidModel",
    Ctrl = require "UI.UIBossraid.Ctrl.UIBossraidCtrl",
    View = require "UI.UIBossraid.View.UIBossraidView",
    PrefabPath = "UI/Prefabs/View/UI/UIBossraid.prefab",
}

local UIBossraidSectionInfo = {
    Name = UIWindowNames.UIBossraidSectionInfo,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIBossraid.Model.UIBossraidSectionInfoModel",
    Ctrl = require "UI.UIBossraid.Ctrl.UIBossraidSectionInfoCtrl",
    View = require "UI.UIBossraid.View.UIBossraidSectionInfoView",
    PrefabPath = "UI/Prefabs/View/UI/UIBossraidSectionInfo.prefab",
}

local UIBossraidTeamInfo = {
    Name = UIWindowNames.UIBossraidTeamInfo,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIBossraid.Model.UIBossraidTeamInfoModel",
    Ctrl = require "UI.UIBossraid.Ctrl.UIBossraidTeamInfoCtrl",
    View = require "UI.UIBossraid.View.UIBossraidTeamInfoView",
    PrefabPath = "UI/Prefabs/View/UI/UIBossraidTeamInfo.prefab",
}

local UIBossraidChooseCard = {
    Name = UIWindowNames.UIBossraidChooseCard,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIBossraid.Model.UIBossraidChooseCardModel",
    Ctrl = require "UI.UIBossraid.Ctrl.UIBossraidChooseCardCtrl",
    -- Ctrl = require "UI.UIFormatNew.UIFormationChooseCard.UIFormationChooseCardCtrl",
    View = require "UI.UICardList.UICardListView",
    PrefabPath = "UI/Prefabs/View/UI/UICardList_Choose.prefab",
}


return {
    UIBossraid = UIBossraid,
    UIBossraidSectionInfo = UIBossraidSectionInfo,
    UIBossraidTeamInfo = UIBossraidTeamInfo,
    UIBossraidChooseCard = UIBossraidChooseCard,
}
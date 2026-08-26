-- chunkname: @modules/logic/rouge2/outside/define/Rouge2_OutsideEvent.lua

module("modules.logic.rouge2.outside.define.Rouge2_OutsideEvent", package.seeall)

local Rouge2_OutsideEvent = _M
local _uid = 1

local function E(name)
	assert(Rouge2_OutsideEvent[name] == nil, "[Rouge2_OutsideEvent] error redefined Rouge2_OutsideEvent." .. name)

	Rouge2_OutsideEvent[name] = _uid
	_uid = _uid + 1
end

E("onFinishViewDone")
E("OnUpdateRougeInfoTalentPoint")
E("OnUpdateRougeOutsideInfo")
E("OnSelectStoreStage")
E("OnBuyStoreGoodsSuccess")
E("OnStoreInfoUpdate")
E("OnStorePointUpdate")
E("onAlchemyInfoUpdate")
E("onAlchemyFormulaClear")
E("onClickAlchemyFormula")
E("onClickAlchemySubMaterial")
E("onSelectAlchemyFormula")
E("onSelectAlchemySubMaterial")
E("onAlchemySuccess")
E("onAlchemyCancel")
E("OnClickCollectionListItem")
E("OnClickCollectionDropItem")
E("OnUpdateFavoriteReddot")
E("SwitchCollectionInfoType")
E("OnSelectCollectionFormulaItem")
E("OnIllustrationScrollViewValueChanged")
E("OnAVGScrollViewValueChanged")
E("ScenePreloaded")
E("SceneSwitch")
E("BackEnterScene")
E("SceneSwitchFinish")
E("CareerSwitchRefresh")
E("CareerSwitchFinish")
E("EnterGame")
E("OnSelectCommonTalent")
E("OnUpdateCommonTalent")
E("OnDetailItemClickClose")
E("OnUpdateRougeTalentInfo")
E("OnSelectHandBookCareer")
E("OnSelectHandBookTalent")
E("OnLevelUpAnimStart")
E("OnLevelUpAnimFinish")
E("OnClickMaterialListItem")
E("OnClearRedDot")
E("OnFormulaItemRefreshFinish")
E("OnMaterialItemRefreshFinish")
E("OnAlchemySuccessOpenFinish")
E("OnAlchemyFormulaItemClick")
E("OnAlchemyMaterialItemClick")
E("OnMainViewInTop")
E("OnFinishAndNotRouge")
E("OnSaveRecordDone")
E("OnUpdateBossBattleInfo")
E("OnSelectBossBattle")

return Rouge2_OutsideEvent

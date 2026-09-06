-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/FormationItem.lua

module("logic.extensions.breakformation.view.FormationItem", package.seeall)

local FormationItem = class("FormationItem")
local scoreIdxList = {
	"D",
	"C",
	"B",
	"A",
	"S"
}

function FormationItem:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
end

function FormationItem.AddOnce(go)
	return GameUtil.AddLuaOnce(go, FormationItem)
end

function FormationItem.Remove(go)
	local obj = GameUtil.GetLua(go, FormationItem)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, FormationItem)
end

function FormationItem:dispose()
	uGuiUtil.clearImage(self.con.gameObject)

	self._viewResLoader = nil
end

function FormationItem:buildUI()
	self._btnGo = goutil.findChild(self.mainGO, "btn"):GetComponent(goutil.Type_RectTransform)
	self._btnBreak = Framework.ButtonAdapter.GetFrom(self.mainGO, "btn")

	self._btnBreak:AddClickListener(self._onClickBreak, self)

	local root = goutil.findChild(self.mainGO, "btn/charactor")

	self.bgHell = goutil.findChild(self.mainGO, "btn/charactor/bgHell")
	self.imgBestRecord = goutil.findChild(self.mainGO, "btn/charactor/imgBestRecord")
	self.txtBestRecord = goutil.findChildTextComponent(self.mainGO, "btn/charactor/imgBestRecord/txtBestRecord")
	self.txtRuleDesc = goutil.findChildTextComponent(self.mainGO, "btn/charactor/txtRuleDesc")
	self.txtRuleTitle = goutil.findChildTextComponent(self.mainGO, "btn/charactor/txtRuleTitle")
	self.imgNo = goutil.findChild(self.mainGO, "btn/charactor/imgNo")
	self.imgLevel = goutil.findChild(self.mainGO, "btn/charactor/imgLevel")
	self._imgLock = goutil.findChild(self.mainGO, "btn/imgLock")
	self.con = goutil.findChildImageComponent(self.mainGO, "btn/charactor/mask/con")
	self._gridItems = goutil.findChild(self.mainGO, "btn/charactor/gridItems")
end

function FormationItem:playFirstShow(idx, fidx)
	GameUtil.setAnchoredPos(self._btnGo, 206, 0)
	self:stopTween()

	self.isPlayMovEnd = false

	self:_stopSelectEffect()

	local time = 0.1
	local delayTime = 0.05 * (7 - (idx - fidx))

	self._btnGo:DOAnchorPosX(0, time):SetDelay(delayTime):SetEase(DG.Tweening.Ease.OutBack):OnComplete(function()
		self:_playSelectEffect(self.mainGO)
	end)
end

function FormationItem:playGetNew()
	self.isPlayNewEff = true

	self:playNewEffect()
end

function FormationItem:stopTween()
	if self._posTween then
		self._posTween:Kill()

		self._posTween = nil
	end
end

function FormationItem:onSetMo(mo, isOpen, parentView, viewResLoader)
	self._mo = mo
	self._isOpen = isOpen
	self.parentView = parentView
	self._viewResLoader = viewResLoader
	self.isPlayMovEnd = false
	self.isPlayNewEff = false

	local periodId = BreakFormationModel.instance.periodId
	local cfg = BreakFormationConfig.instance:getTeamCfg(periodId)

	self:_stopSelectEffect()

	self.txtRuleDesc.text = lang("破阵奖励")
	self.txtRuleTitle.text = mo.isHell and langPara("[地狱]第%s关", mo.index) or langPara("第%s关", mo.index)

	GameUtil.SetActive(self.bgHell, checkbool(mo.isHell))

	if self._photoEff then
		self._photoEff:clear()
	end

	local mode = BreakFormationModel.instance:getCurMode()
	local isNoraml = mode ~= BreakFormationModel.MODE_HELL
	local score = BreakFormationModel.instance:GetPozhanScorelistByType(isNoraml, self._mo.index)

	if score > 0 then
		GameUtil.SetActive(self.imgLevel, false)
		GameUtil.SetActive(self.imgNo, false)
		GameUtil.SetActive(self.imgBestRecord, true)

		self.txtBestRecord.text = score

		local key = BreakFormationConfig.instance:getScoreName(cfg.scoreProcessor, score)
		local idx = table.indexof(scoreIdxList, string.upper(key))

		GameUtil.SetActive(self.imgLevel, true)
		GameUtil.setUIImageSpriteIdx(self.imgLevel, idx - 1)
	else
		GameUtil.SetActive(self.imgNo, true)
		GameUtil.SetActive(self.imgBestRecord, false)
		GameUtil.SetActive(self.imgLevel, false)
		self:_playSelectEffect(self.mainGO)
	end

	goutil.setActive(self._goRecevied, score > 0)
	self:setPetRaceId(mo.showFaceId or 0)
	goutil.setActive(self._imgLock, not self._isOpen)

	local prizes = BreakFormationConfig.instance:GetPozhenProgByWeek(self._mo.teamId)
	local cfg
	local prizes = string.split((self._mo.isHell and BreakFormationConfig.instance:getHellMonsterCfg(self._mo.teamId, self._mo.monsterId) or BreakFormationConfig.instance:getMonsterCfg(self._mo.teamId, self._mo.monsterId)).prize, "#")
	local list = {}

	for i = 1, 2 do
		table.insert(list, prizes[i])
	end

	GameUtil.updateCellsWithCreate(self._gridItems, list, function(cell, data)
		MaterialMgr.setCellByCfg(data, cell)
	end)
end

function FormationItem:_playSelectEffect(go)
	self.isPlayMovEnd = true

	self:_stopSelectEffect()

	local mode = BreakFormationModel.instance:getCurMode()
	local isNoraml = mode ~= BreakFormationModel.MODE_HELL
	local score = BreakFormationModel.instance:GetPozhanScorelistByType(isNoraml, self._mo.index)

	if score <= 0 and self._isOpen then
		local eff = UIEffectManager.instance:playEffectBrief(self.parentView, "fx_ui_breakformationview/fx_ui_breakformationview_selectcelleffects.prefab", go.transform, true, function(ta, eff)
			eff:setScrollRectClipping(self.parentView.ScrollView:GetComponent(typeof(UnityEngine.UI.ScrollRect)))
		end)

		eff:setParent(go.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setSortingOrder(190)

		self._selectEff = eff
	end

	self:playNewEffect()
end

function FormationItem:playNewEffect()
	if self.isPlayMovEnd and self.isPlayNewEff and BreakFormationModel.instance:getNewScoreIdx() == self._mo.index then
		BreakFormationModel.instance:resetNewScoreIdx()
		UIEffectManager.instance:stopEffect(self._boxRefreshEffect)

		local effect_path = "fx_ui_assignmentview/fx_ui_assignmentview_treasurechesteffects.prefab"

		self._boxRefreshEffect = UIEffectManager.instance:playEffect(self.parentView, effect_path, nil, 0, 0, false, nil, function()
			return
		end, function(finishHandler, eff)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end)

		self._boxRefreshEffect:setParent(self.imgLevel.transform)
		self._boxRefreshEffect:setScale(0.4)
	end
end

function FormationItem:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end

	UIEffectManager.instance:stopEffect(self._boxRefreshEffect)
end

function FormationItem:onDestroy()
	return
end

function FormationItem:_onClickBreak()
	if not self._isOpen then
		FloatWordMgr.instance:show(lang("请先通过上一关卡"))
	else
		local index = self._mo.index
		local teamId = self._mo.teamId
		local monsterId = self._mo.monsterId
		local isHell = self._mo.isHell

		BreakFormationController.instance:checkCanFight(index, function()
			BreakFormationModel.instance:setLastIdx(index)
			UIStateManager.instance:push(ViewName.BFMission, teamId, monsterId, isHell)
		end)
	end
end

function FormationItem:setPetRaceId(rid)
	local cfg = CharacterConfig.instance:getPetCo(rid)

	if not cfg then
		printError("t_pet id not exist:" .. rid)

		return
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(cfg.faceIds))

	if not modelCo then
		printError("t_model id not exist:" .. cfg.faceIds)

		return
	end

	local resPath = GameUrl.getPetImgUrl(modelCo.cardName)

	if self._viewResLoader then
		self._viewResLoader:load(self.con.gameObject, resPath, self._onRaceCardResLoad, self)
	else
		uGuiUtil.setSpriteToImage(self.con.gameObject, uGuiUtil.SpriteType.BigBg, resPath)
	end
end

function FormationItem:_onRaceCardResLoad(item)
	local go = item.key

	if goutil.isNil(go) then
		return
	end

	uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, item.resPath)
end

return FormationItem

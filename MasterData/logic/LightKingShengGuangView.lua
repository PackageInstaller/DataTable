-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingShengGuangView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingShengGuangView", package.seeall)

local LightKingShengGuangView = class("LightKingShengGuangView", LightKingBaseView)

function LightKingShengGuangView:unbindEvents()
	LightKingShengGuangView.super.unbindEvents(self)
	self._btnBuff:RemoveClickListener()
end

function LightKingShengGuangView:bindEvents()
	LightKingShengGuangView.super.bindEvents(self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
end

function LightKingShengGuangView:onExit()
	LightKingShengGuangView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	GlobalDispatcher:removeListener(GlobalNotify.LightKingUpgrade, self._onUpgadeRes, self)
end

function LightKingShengGuangView:buildUI()
	LightKingShengGuangView.super.buildUI(self)

	local buff = self:getGo("bottom/buff")

	self._buffIcon = goutil.findChild(buff, "imgIcon")
	self._txtbuffDesc = goutil.findChildTextComponent(buff, "txtDesc")
	self._btnBuff = self:getBtn("bottom/buff/imgIcon")
	self._txtBuffTips = goutil.findChildTextComponent(buff, "txtTips")
end

function LightKingShengGuangView:onEnter()
	LightKingShengGuangView.super.onEnter(self)
	self:_updateBuff()
	GlobalDispatcher:addListener(GlobalNotify.LightKingUpgrade, self._onUpgadeRes, self)
end

function LightKingShengGuangView:_updateBuff()
	local buffLevel = LightKingModel.instance:getCurBuffLevel()
	local buffCfg = LightKingConfig.instance:getBuffCfg(buffLevel)

	if buffCfg ~= nil then
		self._txtbuffDesc.text = buffCfg.des
	end

	self._effs = {}

	if not LightKingModel.instance:getTodayHasUpgrade() then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

		self._eff = self:_playEffect(url, self._buffIcon)
	else
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	local nextBuffCfg = LightKingConfig.instance:getBuffCfg(buffLevel + 1)

	self._txtBuffTips.text = nextBuffCfg and "每日可点击升级挑战祝福" or "已达最高等级"
end

function LightKingShengGuangView:_playEffect(url, parent)
	print("playEffect")

	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(parent:GetComponent(goutil.Type_RectTransform))
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(0.61)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function LightKingShengGuangView:_updateCell(view, cell, data)
	LightKingShengGuangView.super._updateCell(self, view, cell, data)

	local txtRuleDesc = goutil.findChildTextComponent(cell.gameObject, "btn/txtRuleDesc")
	local con = goutil.findChild(cell.gameObject, "btn/mask/con")

	txtRuleDesc.text = data.missionCondition

	local modelCo = CharacterConfig.instance:getModelCo(data.showFaceId)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function LightKingShengGuangView:_onClickCell(cfg)
	LightKingShengGuangView.super._onClickCell(self, cfg)
end

function LightKingShengGuangView:_onClickBuff()
	if LightKingModel.instance:getTodayHasUpgrade() then
		FloatWordMgr.instance:show("今天已经升级过祝福了，请明天再来吧~")
	else
		LightKingController.instance:sendUpgradeReq()
	end
end

function LightKingShengGuangView:_onUpgadeRes()
	self:_updateBuff()
end

return LightKingShengGuangView

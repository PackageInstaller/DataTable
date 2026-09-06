-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NianNianChallView.lua

module("logic.extensions.niannianchall.view.NianNianChallView", package.seeall)

local NianNianChallView = class("NianNianChallView", TableViewComponent)

function NianNianChallView:ctor()
	NianNianChallView.super.ctor(self)
end

function NianNianChallView:unbindEvents()
	NianNianChallView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function NianNianChallView:bindEvents()
	NianNianChallView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._btnRule:AddClickListener(function()
		UIStateManager.instance:open(ViewName.RulesView, "niannianchallstage")
	end)
end

function NianNianChallView:buildUI()
	NianNianChallView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local buff = self:getGo("container/bottom/buff")

	self._txtDesc = self:getTxt("container/bottom/txtDesc")
	self._buffIcon = goutil.findChild(buff, "imgIcon")
	self._txtbuffDesc = goutil.findChildTextComponent(buff, "txtBuffDesc")
	self._btnBuff = self:getBtn("container/bottom/buff/imgIcon")
	self._txtBuffTips = goutil.findChildTextComponent(buff, "txtTips")
	self._btnRule = self:getBtn("btnRule")
	self._txtfinishTimes = self:getTxt("finishTimes/Text")
	self._titleTxt = self:getTxt("upInfoTran/titleTxt")
end

function NianNianChallView:onExit()
	NianNianChallView.super.onExit(self)
	self._tableview:Travel(self._clearCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.NianNianChallBuff, self._updateBuff, self)
end

function NianNianChallView:onEnter()
	NianNianChallView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NianNianChallBuff, self._updateBuff, self)

	self._curViewDatas = NianNianChallConfig.instance:getStageCfgList()
	self._needCenterOn = true
	self._stageId = NianNianChallModel.instance:getStageId()
	self._txtDesc.text = lang("nian_chall_fmt_tip")
	self._titleTxt.text = lang("nian_chall_main_name")

	self:_refresh()
	self:_updateBuff()
end

function NianNianChallView:_refresh()
	self._txtfinishTimes.text = string.format("已通关：%d/%d", self._stageId, #self._curViewDatas)

	self:reloadData()
end

function NianNianChallView:_getPath()
	return {
		cellPath = "container/tablecell",
		viewPath = "container/tableview"
	}
end

function NianNianChallView:_updateCell(view, cell, data)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.addClickHandler(btn, function()
		self:_onClickCell(data)
	end)

	local txtLevel = goutil.findChildTextComponent(btn, "txtLevel")
	local finished = goutil.findChild(btn, "finished")
	local txtIconNum = goutil.findChildTextComponent(btn, "txtIconNum")
	local imgIcon = goutil.findChild(btn, "imgIcon")
	local txtRuleDesc = goutil.findChildTextComponent(btn, "txtRuleDesc")

	txtRuleDesc.text = data.missionCondition
	txtLevel.text = string.format("第%d关", data.stageId)

	local curStage = self._stageId

	uGuiUtil.setGoGrayState(btn, curStage >= data.stageId)
	finished:SetActive(data.stageId > curStage + 1)

	local matType, matId, num = MaterialMgr.getMatParams(data.prize, ":")

	txtIconNum.text = "x" .. num

	MaterialMgr.setIcon(imgIcon, matType, matId)

	local con = goutil.findChild(cell.gameObject, "btn/mask/con")
	local modelCo = CharacterConfig.instance:getModelCo(data.showFaceId)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function NianNianChallView:_clearCell(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)

	local con = goutil.findChild(cell.gameObject, "btn/mask/con")

	uGuiUtil.clearImage(con)
end

function NianNianChallView:_onClickCell(cfg)
	if cfg.stageId < self._stageId + 1 then
		FloatWordMgr.instance:show("已通关！")
	elseif cfg.stageId > self._stageId + 1 then
		FloatWordMgr.instance:show("请先通过前面关卡！")
	elseif checknumber(cfg.nianLoadOpenId) <= NianNianChallModel.instance:getGrowthPath() then
		NianNianChallController.instance:openMission(cfg.stageId)
	else
		TipsFacade.instance:openPopupWindow("", lang("nian_chall_stage_select_tip"), function()
			local actId = checknumber(NianNianChallConfig.instance:getCommonCfg("PET_GROWTH_PATH_ACTIVITY_ID"))

			GrowUpRoadController.instance:openGrowRoadTask(actId, GameEnum.GrowUpRoad.RightTask)
		end, nil, "前往", nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function NianNianChallView:_onReloadFinish()
	local curStage = self._stageId

	for k, v in ipairs(self._curViewDatas) do
		if v.stageId == curStage + 1 then
			self._tableview:MoveCellToCebter(k - 1)
		end
	end
end

function NianNianChallView:_onClickBuff()
	NianNianChallController.instance:sendGetBuff()
end

function NianNianChallView:_updateBuff()
	local buffLevel = NianNianChallModel.instance:getBuffLevel()
	local buffCfg = NianNianChallConfig.instance:getBuffCfg(buffLevel)

	if buffCfg ~= nil then
		self._txtbuffDesc.text = buffCfg.des
	end

	if not NianNianChallModel.instance:getGotBuff() then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

		self:_playEffect(url, self._buffIcon)
	else
		UIEffectManager.instance:stopEffect(self._prizeEffs)

		self._prizeEffs = nil
	end

	local nextBuffCfg = NianNianChallConfig.instance:getBuffCfg(buffLevel + 1)

	self._txtBuffTips.text = nextBuffCfg and "每日可点击升级挑战祝福" or "已达最高等级"
end

function NianNianChallView:_playEffect(url, parent, scale)
	self._prizeEffs = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(parent:GetComponent(goutil.Type_RectTransform))
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end)
end

return NianNianChallView

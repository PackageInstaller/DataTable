-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikebufflevelupView.lua

module("logic.extensions.roguelike.view.RoguelikebufflevelupView", package.seeall)

local RoguelikebufflevelupView = class("RoguelikebufflevelupView", ViewComponent)

function RoguelikebufflevelupView:buildUI()
	RoguelikebufflevelupView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._scrollerGo = self:getGo("tableview")
	self._cellGo = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._txtNum = self:getTxt("txtNum")
	self._txtCoinNum = self:getTxt("txtCoin/txtCoinNum")
	self._imgCoin = self:getGo("txtCoin/imgCoin")
end

function RoguelikebufflevelupView:bindEvents()
	RoguelikebufflevelupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function RoguelikebufflevelupView:unbindEvents()
	RoguelikebufflevelupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function RoguelikebufflevelupView:onEnter()
	RoguelikebufflevelupView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoguelikeLvlUpGlobalBuffRes, self._onLvlUpGlobalBuffRes, self)
	self.addGEvent(self, GlobalNotify.RoguelikeResetGlobalBuffLvlRes, self._onResetGlobalBuffLvlRes, self)
	self.addGEvent(self, GlobalNotify.RoguelikeSetGlobalBuffOnOffRes, self._onSetGlobalBuffOnOffRes, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._onMaterialCountChange, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = RoguelikeConfig.instance:getActivityCfg(self._activityId)
	self._maxBuffNum = checknumber(self._cfgActivity.globalBuffMaxCount)
	self._uiEffectDic = {}

	self:_initBuffList()
	self:_updateBuffNum()
	self:_initCoinIcon()
	self:_updateCoins()
end

function RoguelikebufflevelupView:onExit()
	RoguelikebufflevelupView.super.onExit(self)
	self._scrollList:dispose()
	self:_clearCoinIcon()
	self:_clearEffects()
end

function RoguelikebufflevelupView:_onLvlUpGlobalBuffRes(buffId)
	FloatWordMgr.instance:show("升级成功")
	self:_refreshBuffList(buffId)
end

function RoguelikebufflevelupView:_onResetGlobalBuffLvlRes()
	FloatWordMgr.instance:show("重置成功")
	self:_refreshBuffList()
end

function RoguelikebufflevelupView:_onSetGlobalBuffOnOffRes()
	self:_updateBuffNum()
	self:_refreshBuffList()
end

function RoguelikebufflevelupView:_onMaterialCountChange()
	self:_updateCoins()
end

function RoguelikebufflevelupView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local buffIcon = goutil.findChild(cell, "icon")
	local txtDesc = goutil.findChildTextComponent(cell, "view/viewport/content/txtDesc")
	local costIcon = goutil.findChild(cell, "cost/icon")
	local txtCostNum = goutil.findChildTextComponent(cell, "cost/txtNum")
	local txtBtnLvUp = goutil.findChildTextComponent(cell, "btnLvUp/txt")
	local checkbox = goutil.findChild(cell, "btnSelect/checkbox")
	local btnLvUp = goutil.findChild(cell, "btnLvUp")
	local btnReset = goutil.findChild(cell, "btnReset")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local bg = goutil.findChild(cell, "bg")
	local buffLvCfgs = data
	local cfg = buffLvCfgs[1]
	local isOpen = ServerTime.now() > GameUtil.string2time(cfg.releaseTime)

	if self._lvBuffId and self._lvBuffId == cfg.buffId then
		self:_loadEffect(bg)
	else
		self:_removeEffect(bg)
	end

	uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.iconPath))

	local lv = RoguelikeModel.instance:getGlobalBuffLevel(self._activityId, cfg.buffId)

	txtName.text = cfg.buffName
	txtLv.text = "Lv." .. lv
	txtDesc.text = buffLvCfgs[lv].buffDesc

	local levelUpCfg = buffLvCfgs[lv + 1]
	local costCfg = levelUpCfg

	if costCfg == nil then
		costCfg = buffLvCfgs[lv]
	end

	if costCfg then
		local matType, id, matNum = MaterialMgr.getMatParams(costCfg.lvlUpCost)

		MaterialMgr.setIcon(costIcon, matType, id)

		txtCostNum.text = matNum
	end

	if isOpen then
		if levelUpCfg then
			GameUtil.SetGray(btnLvUp, false)

			txtBtnLvUp.text = "升级"
		else
			GameUtil.SetGray(btnLvUp, true)

			txtBtnLvUp.text = "已满级"
		end
	else
		GameUtil.SetGray(btnLvUp, true)

		local date = GameUtil.string2date(cfg.releaseTime)

		txtBtnLvUp.text = string.format("%d.%d 解锁", date.month, date.day)
	end

	GameUtil.SetGray(btnReset, lv == 1)

	local isUsing = RoguelikeModel.instance:isUsingGlobalBuff(self._activityId, cfg.buffId)

	GameUtil.SetActive(checkbox, isUsing)
	GameUtil.addClickHandler(btnLvUp, function()
		if isOpen then
			if levelUpCfg then
				UIStateManager.instance:push(ViewName.RoguelikebuffleveluptipView, self._activityId, cfg.buffId, lv, lv + 1)
			else
				FloatWordMgr.instance:show("已满级")
			end
		end
	end)
	GameUtil.addClickHandler(btnReset, function()
		if isOpen then
			if lv == 1 then
				FloatWordMgr.instance:show("无需重置等级")
			else
				local matType, id, matNum = RoguelikeController.instance:getGlobalBuffDegradeReturn(self._activityId, cfg.buffId, lv)

				if matType > 0 and id > 0 and matNum > 0 then
					local content = string.format("是否确认重置%s的等级？\n本次返还道具：<quad name=%d:%d|icon size=25 width=1 offsetY=0/>*%d", cfg.buffName, matType, id, matNum)

					TipsFacade.instance:openTipWindow(lang("tip"), content, function()
						RoguelikeAgent.instance:sendPM_RoguelikeResetGlobalBuffLvlReq(self._activityId, cfg.buffId)
					end, nil, UnityEngine.TextAnchor.MiddleCenter)
				end
			end
		end
	end)
	GameUtil.addClickHandler(btnSelect, function()
		printInfo("test btnSelect", isOpen)

		if isOpen then
			local isUsing = RoguelikeModel.instance:isUsingGlobalBuff(self._activityId, cfg.buffId)

			if not isUsing then
				local buffList = RoguelikeModel.instance:getUsingGlobalBuffList(self._activityId)
				local curNum = #buffList

				if curNum >= self._maxBuffNum then
					FloatWordMgr.instance:show("当前生效祝福达到上限，请先取消其他再来选择~")

					return
				end
			end

			RoguelikeAgent.instance:sendPM_RoguelikeSetGlobalBuffOnOffReq(self._activityId, cfg.buffId, not isUsing)
		end
	end)
end

function RoguelikebufflevelupView:_clearCell(cell)
	return
end

function RoguelikebufflevelupView:_initBuffList()
	local buffCfgs = RoguelikeConfig.instance:getGlobalBuffList(self._activityId)

	self._scrollList:reloadData(buffCfgs)
end

function RoguelikebufflevelupView:_refreshBuffList(buffId)
	self._lvBuffId = buffId

	self._scrollList:refresh()
end

function RoguelikebufflevelupView:_updateBuffNum()
	local buffList = RoguelikeModel.instance:getUsingGlobalBuffList(self._activityId)
	local curNum = #buffList

	self._txtNum.text = string.format("当前生效祝福:%d / %d", curNum, self._maxBuffNum)
end

function RoguelikebufflevelupView:_initCoinIcon()
	if not string.nilorempty(self._cfgActivity.globalBuffCoin) then
		local matType, id = MaterialMgr.getMatParams(self._cfgActivity.globalBuffCoin)

		MaterialMgr.setIcon(self._imgCoin, matType, id)
	end
end

function RoguelikebufflevelupView:_clearCoinIcon()
	MaterialMgr.clearIcon(self._imgCoin)
end

function RoguelikebufflevelupView:_updateCoins()
	if not string.nilorempty(self._cfgActivity.globalBuffCoin) then
		local matType, id = MaterialMgr.getMatParams(self._cfgActivity.globalBuffCoin)

		self._txtCoinNum.text = MaterialModel.instance:getMaterialsNumber(matType, id)
	end
end

function RoguelikebufflevelupView:_loadEffect(go)
	self:_removeEffect(go)

	local path = RoguelikebufflevelupViewPresentor.LvUpEffectPath
	local uiEffect = UIEffectManager.instance:playEffect(self, path, go.transform, 0, 0, true, false)

	uiEffect:setParent(go.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, -13, 0)

	self._uiEffectDic[go:GetInstanceID()] = uiEffect
end

function RoguelikebufflevelupView:_removeEffect(go)
	local uiEffect = self._uiEffectDic[go:GetInstanceID()]

	if uiEffect then
		self._uiEffectDic[go:GetInstanceID()] = nil

		UIEffectManager.instance:stopEffect(uiEffect)
	end
end

function RoguelikebufflevelupView:_clearEffects()
	for k, v in pairs(self._uiEffectDic) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._uiEffectDic)
end

return RoguelikebufflevelupView

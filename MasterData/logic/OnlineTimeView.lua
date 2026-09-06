-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/view/OnlineTimeView.lua

module("logic.extensions.onlinetime.view.OnlineTimeView", package.seeall)

local OnlineTimeView = class("OnlineTimeView", ViewComponent)

function OnlineTimeView:ctor()
	OnlineTimeView.super.ctor(self)

	self._rotateDegrees = {
		[0] = 31,
		23,
		7.5,
		-8.3,
		-24,
		-40,
		-56,
		-64
	}
end

function OnlineTimeView:bindEvents()
	for i = 1, 6 do
		self._itemBtns[i]:AddClickListener(function()
			self:_onClickItem(i)
		end)
	end
end

function OnlineTimeView:unbindEvents()
	for i = 1, 6 do
		self._itemBtns[i]:RemoveClickListener()
	end
end

function OnlineTimeView:buildUI()
	self._petBase = self:getGo("Base")
	self._descTxt = self:getGo("TxtDesc"):GetComponent("Text")
	self._timeTxt = self:getGo("TxtTime"):GetComponent("Text")
	self._itemBtns = {}
	self._icons = {}
	self._numTxts = {}
	self._effectObjs = {}
	self._gotObjs = {}
	self._txtTipTimeObjs = {}

	for i = 1, 6 do
		local bgPath = "Items/Cell" .. i .. "/ImgBg/"

		self._itemBtns[i] = self:getBtn(bgPath .. "ImgIcon")
		self._icons[i] = self:getGo(bgPath .. "ImgIcon")
		self._numTxts[i] = self:getGo(bgPath .. "TxtNum"):GetComponent("Text")
		self._effectObjs[i] = self:getGo(bgPath .. "Effect")
		self._gotObjs[i] = self:getGo(bgPath .. "Got")
		self._txtTipTimeObjs[i] = self:getTxt(bgPath .. "txtTipTime")
	end

	self._timeTxtBg = self:getGo("ImgTip/Img")
end

function OnlineTimeView:destroyUI()
	return
end

function OnlineTimeView:onEnter()
	self:_spawnChara(OnlineTimeConfig.instance:getFaceId())
	OnlineTimeController.instance:registerLocalNotify("ItemStatisRefreshed", self._initView, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadInfos, self)
	self:_reloadInfos()

	self._effs = {}

	for i = 1, 6 do
		eff = UIEffectManager.instance:playEffect(self, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", self._effectObjs[i], 0, 0, true, nil, function(finishHandlerTarget, eff)
			eff:setParent(self._effectObjs[i].transform)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._effectObjs[i]) + 1)
		end, nil)

		eff:setParent(self._effectObjs[i].transform)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = false

		table.insert(self._effs, eff)
	end

	self._isRedActive = RedPointModel.instance:isActive(14)
end

function OnlineTimeView:_initView()
	self:_refreshData()
	removetimer(self._updateTime, self)
	self:_updateTime()
	settimer(1, self._updateTime, self)
end

function OnlineTimeView:onEnterFinished()
	return
end

function OnlineTimeView:onExit()
	self:_despawnChara()
	OnlineTimeController.instance:unregisterLocalNotify("ItemStatisRefreshed", self._initView, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadInfos, self)
	removetimer(self._updateTime, self)

	for k, v in pairs(self._icons or {}) do
		MaterialMgr.clearIcon(v)
	end

	for _, v in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effs = nil
end

function OnlineTimeView:_reloadInfos()
	OnlineTimeController.instance:sendGetInfo()
end

function OnlineTimeView:onExitFinished()
	return
end

function OnlineTimeView:_spawnChara(faceId)
	local displayBagOffset = CharactorFacade.instance:getPetBagLihuiModelUIPosAndScale(faceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._chara = RoleObjectPool.instance:addRoleToParent(self._chara, faceId, self._petBase, scale, nil, true, x, y)
end

function OnlineTimeView:_despawnChara()
	RoleObjectPool.instance:removeRole(self._chara)
end

function OnlineTimeView:_updateTime()
	local curActive = RedPointModel.instance:isActive(14)

	if self._isRedActive ~= curActive then
		self._isRedActive = curActive

		print("update red point 14")
		RedPointModel.instance:updateAllRedPoint()
	end

	self._timeTxt.gameObject:SetActive(false)

	if OnlineTimeModel.instance:checkGiftAllget() then
		self._descTxt.text = lang("奖励都已领完\n请明天再来")
	else
		if OnlineTimeModel.instance:getRotateIndex() >= 6 then
			self._descTxt.text = lang("可领取今天所有在线奖励")
		else
			local time = OnlineTimeModel.instance:getTime()
			local hour, min, sec = GameUtil.getTimeHHMMSS(time)

			self._timeTxt.text = string.format("%02d:%02d:%02d", hour, min, sec)

			self._timeTxt.gameObject:SetActive(true)

			self._descTxt.text = lang("距离下次奖励还有")
		end

		local isRedActive = RedPointModel.instance:isActive(14)
	end

	self._timeTxtBg:SetActive(self._timeTxt.gameObject.activeSelf)
end

function OnlineTimeView:_refreshData()
	for i = 1, 6 do
		local data = OnlineTimeModel.instance:getItemData(i)

		goutil.setActive(self._icons[i].gameObject, true)
		self:_updateItem(self._icons[i], self._numTxts[i], data.itemStr)
		self._effectObjs[i]:SetActive(data.status == GameEnum.IconStatus.Can)
		self._gotObjs[i]:SetActive(data.status == GameEnum.IconStatus.Got)

		self._txtTipTimeObjs[i].text = langPara("<size=22>%s</size> 分钟", data.timeCfg)
	end
end

function OnlineTimeView:_updateItem(iconGo, numTxt, itemStr)
	itemStr = string.gsub(itemStr, "=", ":")

	local info = string.split(itemStr, ":")
	local matType = checknumber(info[1])
	local id = checknumber(info[2])

	MaterialMgr.setIcon(iconGo, matType, id)

	numTxt.text = "x" .. info[3]
end

function OnlineTimeView:_onClickItem(idx)
	local data = OnlineTimeModel.instance:getItemData(idx)

	if data.status == GameEnum.IconStatus.Can then
		OnlineTimeController.instance:getPrize(idx)
	else
		CommonTipsMgr.instance:openTipsByConfStr(self._itemBtns[idx].gameObject, data.itemStr)
	end
end

return OnlineTimeView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/view/TimeGateMainView.lua

module("logic.extensions.timegate.view.TimeGateMainView", package.seeall)

local TimeGateMainView = class("TimeGateMainView", ViewComponent)

function TimeGateMainView:ctor()
	TimeGateMainView.super.ctor(self)

	self.loader = {}
end

function TimeGateMainView:buildUI()
	TimeGateMainView.super.buildUI(self)

	self._challengeList = {}

	for i = 1, 2 do
		local go = self:getGo("challenge" .. i)
		local element = {}

		element.go = go
		element.unSelect = goutil.findChild(go, "unSelect")
		element.select = goutil.findChild(go, "select")
		element.con = goutil.findChild(go, "select/con")
		element.txtName = goutil.findChildTextComponent(go, "select/name/txt")
		element.txtDesc = goutil.findChildTextComponent(go, "select/txtDesc")
		element.noGet = goutil.findChild(go, "select/noGet")
		element.txtTime = goutil.findChildTextComponent(go, "select/showDate/txt")
		element.btnClick = Framework.ButtonAdapter.GetFrom(go, "unSelect/btnClick")
		element.btnChange = Framework.ButtonAdapter.GetFrom(go, "select/btnChange")
		element.btnChallenge = Framework.ButtonAdapter.GetFrom(go, "select/btnChallenge")
		element.txtTip1 = goutil.findChildTextComponent(go, "unSelect/txtTip")
		element.txtTip2 = goutil.findChildTextComponent(go, "select/tip/txtTip")
		element.bgSpriteChange = goutil.findChild(go, "select/bg"):GetComponent(ComponentType.UIImageSpriteChange)
		element.attrBgSpriteChange = goutil.findChild(go, "select/attrBg"):GetComponent(ComponentType.UIImageSpriteChange)
		element.attrSpriteChange = goutil.findChild(go, "select/attrBg/attr"):GetComponent(ComponentType.UIImageSpriteChange)
		self._challengeList[i] = element
	end

	self._contains = self:getGo("contains")
	self._preview = self:getGo("preview")
	self._privilegeTips = self:getGo("privilegeTips")
	self._txtPrivilegeTips = self:getTxt("privilegeTips/txt")
	self._tableview = self:getGo("preview/tableview")
	self._tablecell = self:getGo("preview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TimeGateMainView:bindEvents()
	TimeGateMainView.super.bindEvents(self)

	for i, v in ipairs(self._challengeList) do
		v.btnClick:AddClickListener(function()
			self:_onClickSelect(i)
		end)
		v.btnChallenge:AddClickListener(function()
			self:_onClickChallenge(i)
		end)
		v.btnChange:AddClickListener(function()
			self:_onClickChange(i)
		end)
	end
end

function TimeGateMainView:unbindEvents()
	TimeGateMainView.super.unbindEvents(self)

	for i, v in ipairs(self._challengeList) do
		v.btnClick:RemoveClickListener()
		v.btnChallenge:RemoveClickListener()
	end
end

function TimeGateMainView:onEnter()
	TimeGateMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TimeGateInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeGateSelectOpenRes, self._onSelectOpenRes, self)
	TimeGateAgent.instance:sendPM_TimeGateInfoReq()

	local now = ServerTime.now()
	local list = TimeGateConfig.instance:getPreviewList(now)

	ArraySort.sortOn(list, function(a)
		return GameUtil.string2time(a.openTime)
	end, ArraySort.NUMERIC)
	GameUtil.SetActive(self._preview, #list > 0)
	self._scrollList:reloadData(list)
end

function TimeGateMainView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local tag_1 = goutil.findChild(cell, "tag_1")
	local tag_2 = goutil.findChild(cell, "tag_2")

	GameUtil.SetActive(tag_1, false)
	GameUtil.SetActive(tag_2, false)

	if data.type == 1 then
		GameUtil.SetActive(tag_1, true)
	else
		GameUtil.SetActive(tag_2, true)
	end

	MaterialMgr.setCell(MatType.Pet, data.raceId, con)

	local time = GameUtil.formatTimeString("%m.%d", data.openTime)

	txtDesc.text = langPara("%s上新", time)
end

function TimeGateMainView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function TimeGateMainView:onExit()
	TimeGateMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeGateInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeGateSelectOpenRes, self._onSelectOpenRes, self)
	self:_clearAllModel()
	self._scrollList:dispose()
end

function TimeGateMainView:_onGetInfoRes()
	self:_refreshView()
end

function TimeGateMainView:_onSelectOpenRes(status)
	if status ~= nil and status ~= 0 then
		return
	end

	TimeGateAgent.instance:sendPM_TimeGateInfoReq()
end

function TimeGateMainView:_refreshView()
	self:_refreshRegressPrivilegeTips()

	for i, v in ipairs(self._challengeList) do
		self:_refreshChallenge(i, v)
	end
end

function TimeGateMainView:_refreshRegressPrivilegeTips()
	local isActive = TimeGateModel.instance:isRegressPrivilegeActive()

	GameUtil.SetActive(self._privilegeTips, isActive)

	if isActive then
		local normalExtraTimes = TimeGateModel.instance:getRegressExtraTimes(TimeGateModel.Normal)
		local highExtraTimes = TimeGateModel.instance:getRegressExtraTimes(TimeGateModel.High)
		local leftDays = TimeGateModel.instance:getRegressPrivilegeLeftDays()

		self._txtPrivilegeTips.text = normalExtraTimes == highExtraTimes and langPara("回归特权生效中：普通挑战、高阶挑战每周次数各额外+%s次，剩余时间%s天", normalExtraTimes, leftDays) or langPara("回归特权生效中：普通、高阶挑战每周次数分别额外+%s、+%s次，剩余时间%s天", normalExtraTimes, highExtraTimes, leftDays)
	end
end

function TimeGateMainView:_refreshChallenge(typeIndex, element)
	local isExist = TimeGateModel.instance:isExistChallenge(typeIndex)
	local leftTime = TimeGateModel.instance:getLeftTime(typeIndex)
	local timesLimit = TimeGateModel.instance:getTimesLimitWithRegress(typeIndex)
	local str = langPara("本周剩余：%d/%d", leftTime, timesLimit)

	element.txtTip1.text = str
	element.txtTip2.text = str

	if isExist then
		goutil.setActive(element.unSelect, false)
		goutil.setActive(element.select, true)

		local raceId = TimeGateModel.instance:getRaceIdByType(typeIndex)
		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId) % 10 - 1
		local rare = CharacterConfig.instance:getInitRare(raceId)
		local infoPet = PetSkinConfig.instance:getPetSkinCfg(raceId)
		local styCfg = PetStrategyConfig.instance:getStrategyById(raceId)
		local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(raceId)

		element.txtName.text = infoPet.skinName

		if styCfg then
			element.txtDesc.text = styCfg.resume or "请配置精灵攻略表"
		end

		element.txtTime.text = str

		goutil.setActive(element.noGet, not isGet)
		element.attrSpriteChange:SetState(race)
		element.attrBgSpriteChange:SetState(rare)
		element.bgSpriteChange:SetState(rare)
		self:_showRoleModel(raceId, element.con)
	else
		goutil.setActive(element.unSelect, true)
		goutil.setActive(element.select, false)
	end
end

function TimeGateMainView:_onClickSelect(typeIndex)
	self:showTabAt(self._contains, ViewName.TimeGateSelectView, typeIndex)
end

function TimeGateMainView:_onClickChallenge(typeIndex)
	local raceId = TimeGateModel.instance:getRaceIdByType(typeIndex)
	local cfgs = TimeGateConfig.instance:getTypePetCfgList(typeIndex, raceId)

	if cfgs and #cfgs > 0 then
		local paramStr = cfgs[1].param

		if string.nilorempty(paramStr) then
			UIStateManager.instance:push(cfgs[1].viewName)
		else
			local params = string.split(paramStr, "#")

			UIStateManager.instance:push(cfgs[1].viewName, unpack(params))
		end
	end
end

function TimeGateMainView:_onClickChange(typeIndex)
	self:showTabAt(self._contains, ViewName.TimeGateSelectView, typeIndex)
end

function TimeGateMainView:_showRoleModel(skinId, con)
	local curFaceId = skinId
	local offset = CharactorFacade.instance:getFormationModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel(con)

	self.loader[con] = RoleObjectPool.instance:addRoleToParent(self.loader[skinId], curFaceId, con, scale, nil, false, x, y)
end

function TimeGateMainView:_resetRoleModel(con)
	self.loader[con] = RoleObjectPool.instance:removeRole(self.loader[con])
end

function TimeGateMainView:_clearAllModel()
	for skinId, v in pairs(self.loader) do
		self:_resetRoleModel(skinId)
	end
end

return TimeGateMainView

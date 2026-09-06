-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageskinintro/view/LinkageSkinIntroView.lua

module("logic.extensions.linkageskinintro.view.LinkageSkinIntroView", package.seeall)

local LinkageSkinIntroView = class("LinkageSkinIntroView", ViewComponent)

function LinkageSkinIntroView:ctor()
	LinkageSkinIntroView.super.ctor(self)

	self._showTab = 1
	self._getStr = ""
	self._lineOffset = {
		startOffset = {
			x = 20,
			y = 20
		},
		endOffset = {
			x = -10,
			y = -20
		}
	}
end

function LinkageSkinIntroView:buildUI()
	LinkageSkinIntroView.super.buildUI(self)

	self._blockGroup = self:getGo("introduceGroup")
	self._blockCell = self:getGo("introduceCell")
	self._itemGroup = ItemGroup.New(self._blockGroup, self._blockCell)
	self._con = self:getGo("roleCon")
	self._btnGet = self:getBtn("btnGet")
	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._tabGroup = {
		self:getGo("tabCell_1"),
		self:getGo("tabCell_2"),
		self:getGo("tabCell_3"),
		self:getGo("tabCell_4")
	}
end

function LinkageSkinIntroView:bindEvents()
	LinkageSkinIntroView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LinkageSkinIntroView:unbindEvents()
	LinkageSkinIntroView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnClose)
end

function LinkageSkinIntroView:onEnter()
	LinkageSkinIntroView.super.onEnter(self)

	local activityId = 171001
	local activityType = 171
	local timeCfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)
	local startTime = GameUtil.string2date(timeCfg.startTime)
	local startMin = startTime.min

	if startMin < 10 then
		startMin = string.format("0%d", startMin)
	end

	local endTime = GameUtil.string2date(timeCfg.endTime)
	local endMin = endTime.min

	if endMin < 10 then
		endMin = string.format("0%d", endMin)
	end

	self._txtTime.text = langPara("活动时间：%d.%d %d:%s-%d.%d %d:%s", startTime.month, startTime.day, startTime.hour, startMin, endTime.month, endTime.day, endTime.hour, endMin)
	self._showTab = 0

	self:_buildView()
	self:_onClickTab(1)
end

function LinkageSkinIntroView:onExit()
	LinkageSkinIntroView.super.onExit(self)

	for i, v in ipairs(self._tabGroup) do
		local btn = GameUtil.asBtn(v)

		GameUtil.rmClickHandler(btn)
	end

	self._itemGroup:dispose()
	RoleObjectPool.instance:removeRole(self._role)
end

function LinkageSkinIntroView:_buildView()
	local tabsCfg = LinkageSkinIntroConfig.instance:getTabsCfg()

	for i, v in ipairs(tabsCfg) do
		if goutil.isNil(self._tabGroup[i]) then
			break
		end

		local headIcon = goutil.findChild(self._tabGroup[i], "headIcon")
		local btn = GameUtil.asBtn(goutil.findChild(self._tabGroup[i], "raycast"))
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(v.skinId)

		MaterialMgr.resetAll(headIcon)
		MaterialMgr.setIcon(headIcon, MatType.PET_SKIN, v.skinId)
		btn:RemoveClickListener()
		btn:AddClickListener(function()
			self:_onClickTab(i)
		end, self)
	end
end

function LinkageSkinIntroView:_refreshView()
	local tabsCfg = LinkageSkinIntroConfig.instance:getTabsCfg()

	for i, v in ipairs(tabsCfg) do
		if not self._tabGroup[i] then
			break
		end

		local select = goutil.findChild(self._tabGroup[i], "select")
		local redPoint = goutil.findChild(self._tabGroup[i], "redpoint")

		if self._showTab == i then
			GameUtil.SetActive(select, true)
		else
			GameUtil.SetActive(select, false)
		end

		local isOpen = ServerTime.now() - GameUtil.string2time(v.openTime) >= 0

		GameUtil.SetActive(redPoint, isOpen and LinkageSkinIntroModel.instance:haveRedPointOnTab(i))
	end

	local tabCfg = LinkageSkinIntroConfig.instance:getTabCfg(self._showTab)

	if not self._donotLoadRole then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, tabCfg.skinId, self._con, tabCfg.scale, nil, true, tabCfg.pos[1], tabCfg.pos[2])
	end

	self:_resetGetBtn(tabCfg.skinId)

	local blocksCfg = LinkageSkinIntroConfig.instance:getBlocksByTab(self._showTab)

	self._itemGroup:updateWithMoArray(blocksCfg, self._updateCell, self)
end

function LinkageSkinIntroView:_updateCell(item, cfg, i)
	local line = goutil.findChild(item.mainGO, "line")
	local descGo = goutil.findChild(item.mainGO, "desc")
	local desTxt = goutil.findChildTextComponent(item.mainGO, "desc/ImgC_ContentBg/TxtC_Content")
	local desImg = goutil.findChild(item.mainGO, "desc/img/con")
	local desImgGo = goutil.findChild(item.mainGO, "desc/img")
	local isRight = true

	if cfg.startPos[1] < cfg.endPos[1] then
		GameUtil.setLocalScale(line, -1, 1, 1)

		isRight = true
	else
		GameUtil.setLocalScale(line, 1, 1, 1)

		isRight = false
	end

	local isUp

	if cfg.startPos[2] < cfg.endPos[2] then
		GameUtil.setLocalScale(line, -1, 1, 1)

		isUp = true
	else
		GameUtil.setLocalScale(line, 1, 1, 1)

		isUp = false
	end

	if isUp == false and isRight == false then
		GameUtil.setLocalScale(line, 1, 1, 1)
	elseif isUp == true and isRight == false then
		GameUtil.setLocalScale(line, 1, -1, 1)
	elseif isUp == false and isRight == true then
		GameUtil.setLocalScale(line, -1, 1, 1)
	elseif isUp == true and isRight == true then
		GameUtil.setLocalScale(line, -1, -1, 1)
	end

	local linePosX, linePoxY

	linePosX = isRight == true and cfg.startPos[1] - self._lineOffset.startOffset.x or cfg.startPos[1] + self._lineOffset.startOffset.x

	local width = math.abs(cfg.startPos[1] - cfg.endPos[1]) + math.abs(self._lineOffset.startOffset.x) + math.abs(self._lineOffset.endOffset.x)

	if width < 10 then
		width = 10
	end

	GameUtil.setWidth(line, width)

	local height

	if isUp == true then
		linePoxY = cfg.startPos[2] - self._lineOffset.startOffset.y
		height = math.abs(cfg.startPos[2] - cfg.endPos[2]) + math.abs(self._lineOffset.startOffset.y) - math.abs(self._lineOffset.endOffset.y)
	else
		linePoxY = cfg.startPos[2] + self._lineOffset.startOffset.y
		height = math.abs(cfg.startPos[2] - cfg.endPos[2]) + math.abs(self._lineOffset.startOffset.y) + math.abs(self._lineOffset.endOffset.y)
	end

	if height < 10 then
		height = 10
	end

	GameUtil.setHeight(line, height)
	GameUtil.setAnchoredPos(line, linePosX, linePoxY)
	GameUtil.setAnchoredPos(descGo, cfg.endPos[1], cfg.endPos[2])

	desTxt.text = cfg.desc

	uGuiUtil.clearImage(desImg)

	if not string.nilorempty(cfg.res) then
		GameUtil.SetActive(desImgGo, true)
		uGuiUtil.setSpriteToImage(desImg, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.res))
		GameUtil.setAnchoredPos(desImgGo, cfg.resPos[1], cfg.resPos[2])
	else
		GameUtil.SetActive(desImgGo, false)
	end
end

function LinkageSkinIntroView:_clearCell(item)
	local desImg = goutil.findChild(v, "desc/img")

	uGuiUtil.clearImage(desImg)
end

function LinkageSkinIntroView:changeTab(idx)
	self._showTab = idx

	self:_refreshView()
end

function LinkageSkinIntroView:_resetGetBtn(cfg)
	self._getStr = string.format("%d:%d", MatType.PET_SKIN, cfg)
end

function LinkageSkinIntroView:_onClickGet()
	if not string.nilorempty(self._getStr) then
		MaterialMgr.openGetSourceByStr(self._getStr)
		SurveyController.instance:reportBehavior(201160)
	end
end

function LinkageSkinIntroView:_onClickTab(idx)
	if idx ~= self._showTab then
		local tabCfg = LinkageSkinIntroConfig.instance:getTabCfg(idx)

		if ServerTime.now() - GameUtil.string2time(tabCfg.openTime) < 0 then
			FloatWordMgr.instance:show(langPara("未到开放时间"))

			return
		end

		if LinkageSkinIntroModel.instance:haveRedPointOnTab(idx) then
			LinkageSkinIntroModel.instance:setReadStaus(idx)

			if tabCfg.operaId then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, tabCfg.operaId)
			end

			self:changeTab(idx)
		else
			self:changeTab(idx)
		end

		SurveyController.instance:reportBehavior(tabCfg.reportBehavior)
	end

	LinkageSkinIntroModel.instance:refreshRedpoint()
end

return LinkageSkinIntroView

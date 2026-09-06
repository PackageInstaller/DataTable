-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspacenorView.lua

module("logic.extensions.phantomspace.view.PhantomspacenorView", package.seeall)

local PhantomspacenorView = class("PhantomspacenorView", ViewComponent)

function PhantomspacenorView:ctor()
	PhantomspacenorView.super.ctor(self)
end

function PhantomspacenorView:unbindEvents()
	PhantomspacenorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PhantomspacenorView:bindEvents()
	PhantomspacenorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PhantomspacenorView:buildUI()
	PhantomspacenorView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/red")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PhantomspacenorView:onExit()
	PhantomspacenorView.super.onExit(self)
	self._scrollList:dispose()
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function PhantomspacenorView:onEnter()
	PhantomspacenorView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PhantomSpaceController.instance:getDefaultActivityId()
	end

	self.addGEvent(self, GlobalNotify.PHANTOM_SPACE_INFO_UPDATE, self._onRefreshUI, self)
	PhantomSpaceController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function PhantomspacenorView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活\nBuff"
	end
end

function PhantomspacenorView:_onRefreshUI()
	self._mode = 0
	self._info = PhantomSpaceModel.instance:getInfo(self._activityId) or {}
	self._stageKey = self._info.stageKey or {}
	self._phantomMonster = self._info.phantomMonster or {}
	self._curStageId = checknumber(self._stageKey.stageId) + 1

	local list = PhantomSpaceConfig.instance:getStageListCfgById(self._activityId, self._mode) or {}

	self._scrollList:reloadData(list)
	self._scrollList:MoveCellToCenter(checknumber(self._stageKey.stageId))
end

function PhantomspacenorView:_updateCell(view, cell, data, tag)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local bubble = goutil.findChild(cell, "bubble")
	local item = goutil.findChild(cell, "bubble/item")
	local geted = goutil.findChild(cell, "bubble/geted")
	local btn_1 = goutil.findChild(cell, "btn_1")
	local btn_2 = goutil.findChild(cell, "btn_2")
	local btnReset = goutil.findChild(cell, "btnReset")
	local imgPass1 = goutil.findChild(cell, "team1/imgPass")
	local imgWait1 = goutil.findChild(cell, "team1/imgWait")
	local imgPass2 = goutil.findChild(cell, "team2/imgPass")
	local imgWait2 = goutil.findChild(cell, "team2/imgWait")
	local imgLock = goutil.findChild(cell, "team2/imgLock")

	GameUtil.SetActive(btnReset, false)
	GameUtil.SetActive(imgPass1, false)
	GameUtil.SetActive(imgWait1, false)
	GameUtil.SetActive(imgPass2, false)
	GameUtil.SetActive(imgWait2, false)
	GameUtil.SetActive(imgLock, false)
	GameUtil.SetActive(geted, false)

	txtTitle.text = langPara("第%s关", data.stageId)

	MaterialMgr.setCellByCfg(data.prize, item)
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, data))
	GameUtil.addClickHandler(btn_1, GameUtil.handler(self._onClickFightNor, self, data))
	GameUtil.addClickHandler(btn_2, GameUtil.handler(self._onClickFightEnemy, self, data))

	local map = {}
	local cfgCreeps = PhantomSpaceConfig.instance:getCreeps(data.creepsMasterId) or {}

	for i, cfgEnemy in ipairs(cfgCreeps) do
		map[cfgEnemy.posId] = cfgEnemy
	end

	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("team1/cell_%d", i))
		local con = goutil.findChild(cell, string.format("team1/cell_%d/icon", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)

		local cfgEnemy = map[i]

		if cfgEnemy then
			goutil.setActive(go, true)
			GameUtil.setLocalScale(con, 0.7, 0.7, 0.7)
			MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, con)
		end

		local go2 = goutil.findChild(cell, string.format("team2/cell_%d", i))
		local con2 = goutil.findChild(cell, string.format("team2/cell_%d/icon", i))

		MaterialMgr.resetAll(con2)
		goutil.setActive(go2, false)
	end

	if data.stageId == self._curStageId then
		if self._phantomMonster.curForm then
			GameUtil.SetActive(imgPass1, true)
			GameUtil.SetActive(btnReset, true)
			GameUtil.SetActive(imgWait2, true)

			if not self._phantomMonster.curForm then
				if not self._phantomMonster.petSimpleView then
					local petSimpleView = {}
					local simpleMap = {}

					for i, v in ipairs(petSimpleView) do
						simpleMap[v.petId] = v.curFaceId
					end

					if not self._phantomMonster.curForm.pos then
						local pos = {}

						for i = 1, 9 do
							local go = goutil.findChild(cell, string.format("team2/cell_%d", i))
							local con = goutil.findChild(cell, string.format("team2/cell_%d/icon", i))
							local petId = pos[i]
							local raceId = simpleMap[petId]

							if raceId then
								goutil.setActive(go, true)
								GameUtil.setLocalScale(con, 0.7, 0.7, 0.7)
								MaterialMgr.setCell(MatType.Pet, raceId, con)
							end
						end
					end
				end
			end
		else
			GameUtil.SetActive(imgLock, true)
			GameUtil.SetActive(imgWait1, true)
		end
	elseif data.stageId > self._curStageId then
		GameUtil.SetActive(imgLock, true)
	elseif data.stageId < self._curStageId then
		GameUtil.SetActive(imgPass1, true)
		GameUtil.SetActive(imgPass2, true)
		GameUtil.SetActive(geted, true)
	end
end

function PhantomspacenorView:_clearCell(cell)
	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("team1/cell_%d", i))
		local con = goutil.findChild(cell, string.format("team1/cell_%d/con", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)

		local go2 = goutil.findChild(cell, string.format("team2/cell_%d", i))
		local con2 = goutil.findChild(cell, string.format("team2/cell_%d/con", i))

		MaterialMgr.resetAll(con2)
		goutil.setActive(go2, false)
	end
end

function PhantomspacenorView:_onClickReset(data)
	local content = "重置后幻象阵容将被清空，并需重新挑战系统阵容\n是否确认重置本关的系统阵容？"

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		PhantomSpaceController.instance:sendResetInfo(self._activityId, self._mode, self._stageKey.buffLv, self._curStageId)
	end)
end

function PhantomspacenorView:_onClickFightNor(data)
	if data.stageId == self._curStageId then
		if self._phantomMonster.curForm then
			TipsFacade.instance:openCommonTips("重置后可重新挑战")
		else
			PhantomSpaceController.instance:openNorFmtView(self._activityId, self._mode, self._stageKey.buffLv, self._curStageId, self._viewPresentor.viewName)
		end
	elseif data.stageId > self._curStageId then
		TipsFacade.instance:openCommonTips("请先通关前置关卡")
	elseif data.stageId < self._curStageId then
		TipsFacade.instance:openCommonTips("已通关")
	end
end

function PhantomspacenorView:_onClickFightEnemy(data)
	if data.stageId == self._curStageId then
		if self._phantomMonster.curForm then
			PhantomSpaceController.instance:openEnemyFmtView(self._activityId, self._mode, self._stageKey.buffLv, self._curStageId, self._viewPresentor.viewName)
		else
			TipsFacade.instance:openCommonTips("请先通关前置关卡")
		end
	elseif data.stageId > self._curStageId then
		TipsFacade.instance:openCommonTips("请先通关前置关卡")
	elseif data.stageId < self._curStageId then
		TipsFacade.instance:openCommonTips("已通关")
	end
end

return PhantomspacenorView

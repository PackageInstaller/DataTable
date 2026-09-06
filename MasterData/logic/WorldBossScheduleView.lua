-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossScheduleView.lua

module("logic.extensions.worldboss.view.WorldBossScheduleView", package.seeall)

local WorldBossScheduleView = class("WorldBossScheduleView", ViewComponent)

function WorldBossScheduleView:ctor()
	WorldBossScheduleView.super.ctor(self)
end

function WorldBossScheduleView:buildUI()
	WorldBossScheduleView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._viewParticleMask = ParticleMask.Get(self:getGo("view/Viewport"))
	self._cell = self:getGo("cell")
	self._view = ScrollerList.create(self:getGo("view"), self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemCell = self:getGo("itemCell")
end

function WorldBossScheduleView:bindEvents()
	WorldBossScheduleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function WorldBossScheduleView:unbindEvents()
	WorldBossScheduleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function WorldBossScheduleView:destroyUI()
	WorldBossScheduleView.super.destroyUI(self)
end

function WorldBossScheduleView:onEnter()
	WorldBossScheduleView.super.onEnter(self)

	self._cellBgState = {
		0,
		0,
		0,
		1,
		2,
		2,
		2
	}
	self._viewProxy = {}
	self._itemProxy = {}
	self._items = {}

	self._viewParticleMask:SetScrollRect(goutil.findChildComponent(self.mainGO, "view", "ScrollRect"))
	WorldBossAgent.instance:sendPM_WorldBossHisotryReq(function(msg)
		local bossSchedule = WorldBossModel.instance:getBossSchedule()
		local infoList = {}

		for i, v in ipairs(msg.info) do
			infoList[v.id] = v
		end

		for i, info in ipairs(bossSchedule) do
			local v = infoList[info.id]

			if v and checknumber(v.rank) > 0 then
				info.rank = v.rank
				info.damage = v.damage
			end
		end

		self._view:reloadData(bossSchedule)
	end)
end

function WorldBossScheduleView:onEnterFinished()
	WorldBossScheduleView.super.onEnterFinished(self)
end

function WorldBossScheduleView:onExit()
	WorldBossScheduleView.super.onExit(self)
	self._view:dispose()
end

function WorldBossScheduleView:onExitFinished()
	WorldBossScheduleView.super.onExitFinished(self)
end

function WorldBossScheduleView:_updateCell(view, cell, data)
	cell.gameObject:GetComponent("UIImageSpriteChange"):SetState(self._cellBgState[data.index])

	if self._viewProxy[cell] then
		local petCo = TableUtil.deepcopy(CharacterConfig.instance:getPetCo(data.raceId))

		petCo.name = data.name

		self._viewProxy[cell].binder:setCfgData(petCo)
		self._viewProxy[cell].binder:setCallBack(function()
			petCo.level = petCo.maxLv
			petCo._curZdl = FightingPowerFormula.instance:getPetMaxFightingPower(data.raceId)
			petCo.curFaceId = checknumber(petCo.faceIds)

			CommonTipsMgr.instance:showPetTips(petCo)
		end)
		self._viewProxy[cell].binder:hideStar()
		self._viewProxy[cell].binder:hideEff()
	else
		self._viewProxy[cell] = MaterialMgr.setCell(MatType.Pet, data.raceId, goutil.findChild(cell.gameObject, "head"))

		local petCo = TableUtil.deepcopy(CharacterConfig.instance:getPetCo(data.raceId))

		petCo.name = data.name

		self._viewProxy[cell].binder:setCfgData(petCo)
		self._viewProxy[cell].binder:setAutoTips(false)
		self._viewProxy[cell].binder:setCallBack(function()
			petCo.level = petCo.maxLv
			petCo._curZdl = FightingPowerFormula.instance:getPetMaxFightingPower(data.raceId)
			petCo.curFaceId = checknumber(petCo.faceIds)

			CommonTipsMgr.instance:showPetTips(petCo)
		end)
		self._viewProxy[cell].binder:hideStar()
		self._viewProxy[cell].binder:hideEff()
		GameUtil.setLocalScale(self._viewProxy[cell].view.transform, 0.9, 0.9, 1)
	end

	goutil.findChildTextComponent(cell.gameObject, "name").text = data.name

	local damage = goutil.findChildTextComponent(cell.gameObject, "damage")

	if data.index <= 4 then
		if data.damage then
			goutil.setActive(damage.gameObject, true)
			goutil.setActive(goutil.findChild(damage.gameObject, "icon"), true)
			goutil.setActive(goutil.findChild(cell.gameObject, "txtTip"), false)

			damage.text = data.damage
		else
			goutil.setActive(damage.gameObject, false)
			goutil.setActive(goutil.findChild(cell.gameObject, "txtTip"), true)
		end

		goutil.findChildTextComponent(cell.gameObject, "rank").text = data.rank and string.format("%d名", data.rank) or data.index < 4 and "未上榜" or WorldBossController.instance:_getBossBeginTime() > ServerTime.now() and "未开启" or checknumber(WorldBossController.instance:_getBossEndTime()) < ServerTime.now() and "未上榜" or "挑战中"
	else
		goutil.setActive(goutil.findChild(cell.gameObject, "txtTip"), false)
		goutil.setActive(damage.gameObject, true)
		goutil.setActive(goutil.findChild(damage.gameObject, "icon"), false)

		damage.text = string.format("%s天后开启", ConstString.ChineseNumber[data.index - 4])
		goutil.findChildTextComponent(cell.gameObject, "rank").text = "未开启"
	end

	local prizeList = string.split(data.prize, "#")

	if self._items[cell] == nil then
		self._items[cell] = {}
	end

	for i = 1, 4 do
		local item = goutil.findChild(cell.gameObject, "items/item_" .. i)

		if prizeList[i] then
			if self._items[cell][i] then
				local prizeInfo = string.split(prizeList[i], ":")

				self._items[cell][i].binder:setCfgData(MaterialMgr.getMatCfg(prizeInfo[1], prizeInfo[2]))
			else
				self._items[cell][i] = MaterialMgr.setCellByCfg(prizeList[i], item)

				GameUtil.setLocalScale(self._items[cell][i].view.transform, 0.9, 0.9, 1)
			end

			goutil.setActive(item, true)
			self._items[cell][i].binder:setNum(0)
		else
			goutil.setActive(item, false)
		end
	end
end

function WorldBossScheduleView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)

	if self._items and cell then
		for i, value in ipairs(self._items[cell]) do
			MaterialMgr.resetAll(value)
		end
	end
end

return WorldBossScheduleView

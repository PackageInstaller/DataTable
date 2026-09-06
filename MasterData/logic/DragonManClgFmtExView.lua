-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/view/DragonManClgFmtExView.lua

module("logic.extensions.dragonmanclg.view.DragonManClgFmtExView", package.seeall)

local DragonManClgFmtExView = class("DragonManClgFmtExView", ViewComponent)

function DragonManClgFmtExView:ctor()
	DragonManClgFmtExView.super.ctor(self)
end

function DragonManClgFmtExView:unbindEvents()
	DragonManClgFmtExView.super.unbindEvents(self)
end

function DragonManClgFmtExView:bindEvents()
	DragonManClgFmtExView.super.bindEvents(self)
end

function DragonManClgFmtExView:buildUI()
	DragonManClgFmtExView.super.buildUI(self)

	self._cellcopy = self:getGo("cellcopy")

	goutil.setActive(self._cellcopy, false)

	self._enemyCellList = {}

	for i = 1, 9 do
		local cell = {}
		local parent = self:getGo("enemy/pos_" .. i)

		cell.go = goutil.cloneAndSetParent(self._cellcopy, parent.transform, "cellcopy")

		GameUtil.setAnchoredPos(cell.go, 0, 0)

		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.bgChagne = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
		self._enemyCellList[i] = cell
	end

	self._myCellList = {}

	for i = 1, 9 do
		local cell = {}
		local parent = self:getGo("my/pos_" .. i)

		cell.go = goutil.cloneAndSetParent(self._cellcopy, parent.transform, "cellcopy")

		GameUtil.setAnchoredPos(cell.go, 0, 0)

		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.bgChagne = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
		self._myCellList[i] = cell
	end
end

function DragonManClgFmtExView:onExit()
	DragonManClgFmtExView.super.onExit(self)
end

function DragonManClgFmtExView:onEnter()
	DragonManClgFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo.activityId
	self._checkRaceMap = {}

	for i, cell in pairs(self._enemyCellList) do
		goutil.setActive(cell.go, false)
	end

	local cfgs = self._customFmtMo:getMonsterConfigList()

	for _, cfg in ipairs(cfgs) do
		local markId = cfg.buffMark

		if markId and markId > 0 then
			local markCfg = DragonManClgConfig.instance:getMarkCfgById(self._activityId, markId)

			if markCfg then
				if not markCfg.actRaceIds then
					for _, raceId in pairs(markCfg.actRaceIds) do
						self._checkRaceMap[raceId] = markCfg
					end

					local cell = self._enemyCellList[cfg.posId]

					if cell then
						goutil.setActive(cell.go, true)

						if not markCfg.eMarkDesc then
							cell.txt.text = markCfg.eMarkDesc

							cell.bgChagne:ChangeSprite(markCfg.bgPicPath)
						end
					end
				end
			end
		end
	end

	self:_updateMFmt()
	self.addGEvent(self, GlobalNotify.PM_DragonManClgFmtChangeRes, self._updateMFmt, self)
end

function DragonManClgFmtExView:_updateMFmt()
	for i, cell in pairs(self._myCellList) do
		goutil.setActive(cell.go, false)
	end

	if not self._checkRaceMap or next(self._checkRaceMap) == nil then
		return
	end

	local fmo = self._customFmtMo:getCurFormation()
	local positions = fmo:GetPositions() or {}

	for i, v in pairs(positions) do
		if v and v > 0 then
			local petMo = fmo:_getPet(v)

			if petMo then
				local raceId = petMo.raceId
				local markCfg = self._checkRaceMap[raceId]

				if markCfg then
					goutil.setActive(self._myCellList[i].go, true)

					self._myCellList[i].txt.text = markCfg.mMarkDesc or ""

					self._myCellList[i].bgChagne:ChangeSprite(markCfg.bgPicPath)
				end
			end
		end
	end
end

return DragonManClgFmtExView

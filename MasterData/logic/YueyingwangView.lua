-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/YueyingwangView.lua

module("logic.extensions.bonus.view.christmasandnewyear.YueyingwangView", package.seeall)

local YueyingwangView = class("YueyingwangView", SummarySubTabView)

function YueyingwangView:ctor()
	YueyingwangView.super.ctor(self)
end

function YueyingwangView:init()
	YueyingwangView.super.init(self)

	self.petIdCfgs = string.split(self._cfgs[1].params, "#")
end

function YueyingwangView:unbindEvents()
	for i = 1, #self.petIdCfgs do
		GameUtil.rmClickHandler(self.btnInfo[i])
	end

	YueyingwangView.super.unbindEvents(self)
end

function YueyingwangView:bindEvents()
	YueyingwangView.super.bindEvents(self)

	for i = 1, #self.petIdCfgs do
		GameUtil.addClickHandler(self.btnInfo[i], GameUtil.handler(self.onClickInfo, self, i))
	end
end

function YueyingwangView:buildUI()
	YueyingwangView.super.buildUI(self)

	self.txtTime = {}
	self.txtDesc = {}

	for _, cfg in pairs(self._cfgs) do
		self.txtTime[cfg.id] = self:getTxt("con" .. cfg.id .. "/txtTime")
		self.txtDesc[cfg.id] = self:getTxt("con" .. cfg.id .. "/txtDesc")
	end

	self.rare = {}
	self.btnInfo = {}

	for i = 1, #self.petIdCfgs do
		self.rare[i] = self:getGo("petInfo_" .. i .. "/rare")
		self.btnInfo[i] = self:getGo("petInfo_" .. i .. "/btnInfo")
	end
end

function YueyingwangView:onExit()
	for i = 1, #self.petIdCfgs do
		if checknumber(self.petIdCfgs[i]) > 0 then
			MaterialMgr.resetAll(self.rare[i])
		end
	end

	YueyingwangView.super.onExit(self)
end

function YueyingwangView:onEnter()
	YueyingwangView.super.onEnter(self)
	self:updateUI()
end

function YueyingwangView:updateUI()
	for _, cfg in pairs(self._cfgs) do
		local timeStart = GameUtil.string2date(cfg.actStartTime, true)
		local timeEnd = GameUtil.string2date(cfg.actEndTime, true)

		self.txtTime[cfg.id].text = string.format("%d月%d日 %d:%02d-%d月%d日 %d:%02d", timeStart.month, timeStart.day, timeStart.hour, timeStart.min, timeEnd.month, timeEnd.day, timeEnd.hour, timeEnd.min)
		self.txtDesc[cfg.id].text = cfg.params
	end

	for i = 1, #self.petIdCfgs do
		if checknumber(self.petIdCfgs[i]) > 0 then
			MaterialMgr.setCell(MatType.Rare, self.petIdCfgs[i], self.rare[i])
		end
	end
end

function YueyingwangView:onClickInfo(i)
	PetbookController.instance:openPetinfoView(checknumber(self.petIdCfgs[i]))
end

return YueyingwangView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMatchSuccView.lua

module("logic.extensions.rankrace.view.RankRaceMatchSuccView", package.seeall)

local RankRaceMatchSuccView = class("RankRaceMatchSuccView", ViewComponent)

function RankRaceMatchSuccView:ctor()
	RankRaceMatchSuccView.super.ctor(self)
end

function RankRaceMatchSuccView:buildUI()
	RankRaceMatchSuccView.super.buildUI(self)

	self._imgTitle = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
	self._imgHead = {}
	self._tagBg = {}
	self._imgTag = {}
	self._txtName = {}
	self._txtGrade = {}
	self._txtScore = {}
	self._imgPorFont = {}

	for i = 1, 2 do
		self._imgHead[i] = self:getGo("playerInfo_" .. i .. "/imgHead")
		self._tagBg[i] = self:getGo("playerInfo_" .. i .. "/tagBg"):GetComponent("UIImageSpriteChange")
		self._imgTag[i] = self:getGo("playerInfo_" .. i .. "/imgTag"):GetComponent("UIImageSpriteChange")
		self._txtName[i] = self:getGo("playerInfo_" .. i .. "/txtName"):GetComponent("Text")
		self._txtGrade[i] = self:getGo("playerInfo_" .. i .. "/txtGrade"):GetComponent("Text")
		self._txtScore[i] = self:getGo("playerInfo_" .. i .. "/txtScore"):GetComponent("Text")

		local _imgPorBk = self:getGo("playerInfo_" .. i .. "/imgPorBk")

		self._imgPorFont[i] = goutil.findChildImageComponent(_imgPorBk.gameObject, "imgPorFont")
	end
end

function RankRaceMatchSuccView:bindEvents()
	RankRaceMatchSuccView.super.bindEvents(self)
end

function RankRaceMatchSuccView:unbindEvents()
	RankRaceMatchSuccView.super.unbindEvents(self)
end

function RankRaceMatchSuccView:destroyUI()
	RankRaceMatchSuccView.super.destroyUI(self)
end

function RankRaceMatchSuccView:onEnter()
	RankRaceMatchSuccView.super.onEnter(self)

	self._viewType = RankRaceController.instance:getCurViewType()

	self._imgTitle:SetState(self._viewType)

	local msg = RankRaceController.instance:getNotifyBeginGameResData()
	local _myAreaName = RankRaceController.instance:getMyAreaIdAndAreaName()

	self._txtName[1].text = _myAreaName and _myAreaName .. "\n" .. RoleModel.instance:getUserName() or RoleModel.instance:getUserName()

	HeadItemController.instance:setMyHeadCell(self._imgHead[1])

	local _openRankingMatchData = RankRaceController.instance:getOpenRankingMatchData(self._viewType)

	if _openRankingMatchData then
		local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(_openRankingMatchData.star)

		if _configRankRaceLevel then
			self._txtGrade[1].text = _configRankRaceLevel._levelName or ""
		end

		self._tagBg[1]:SetState(_configRankRaceLevel._bigLevel - 1)
		self._imgTag[1]:SetState(_configRankRaceLevel._subLevel - 1)

		self._txtScore[1].text = _configRankRaceLevel._bigLevel < 8 and "" or string.format("%s积分", _openRankingMatchData.legendRankScore)
	end

	if msg.opHeadInfo and msg.opHeadInfo.areaName then
		local _areaName = RankRaceController.instance:parseOpAreaInfo(msg.opHeadInfo)

		self._txtName[2].text = _areaName and _areaName .. "\n" .. msg.opHeadInfo.userName or msg.opHeadInfo.userName
	else
		self._txtName[2].text = msg.opHeadInfo.userName
	end

	HeadItemController.instance:setHeadCellByInfo(self._imgHead[2], msg.opHeadInfo)

	local _opConfigRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(msg.opStar)

	if _opConfigRankRaceLevel then
		self._txtGrade[2].text = _opConfigRankRaceLevel._levelName or ""
	end

	self._tagBg[2]:SetState(_opConfigRankRaceLevel._bigLevel - 1)
	self._imgTag[2]:SetState(_opConfigRankRaceLevel._subLevel - 1)

	self._txtScore[2].text = _opConfigRankRaceLevel._bigLevel < 8 and "" or string.format("%s积分", msg.opLegendRankScore)
	self.updateSliderCount = 0

	settimer(0.01, self._updateSlider, self, true)
	self.registerNotify(self, GlobalNotify.RankRaceResult, self._onRankRaceResult, self)
end

function RankRaceMatchSuccView:onEnterFinished()
	RankRaceMatchSuccView.super.onEnterFinished(self)
end

function RankRaceMatchSuccView:onExit()
	RankRaceMatchSuccView.super.onExit(self)
	removetimer(self._updateSlider, self)
	self.unregisterNotify(self, GlobalNotify.RankRaceResult, self._onRankRaceResult, self)
end

function RankRaceMatchSuccView:onExitFinished()
	RankRaceMatchSuccView.super.onExitFinished(self)
end

function RankRaceMatchSuccView:_updateSlider()
	local _maxCount = 150

	self.updateSliderCount = self.updateSliderCount + 3

	if _maxCount < self.updateSliderCount then
		self.updateSliderCount = _maxCount
	end

	for i = 1, 2 do
		self._imgPorFont[i].fillAmount = self.updateSliderCount / _maxCount
	end

	if _maxCount <= self.updateSliderCount then
		removetimer(self._updateSlider, self)

		local msg = RankRaceController.instance:getNotifyBeginGameResData()

		if msg then
			RankRaceFmtController.instance:notifyBeginGame(msg)
			RankRaceResultModel.instance:clearGameResult()
		end

		self:close()
	end
end

function RankRaceMatchSuccView:_onRankRaceResult()
	local state = RankRaceResultModel.instance:getRankRaceState()

	if state ~= RankRaceResultModel.State_Normal then
		removetimer(self._updateSlider, self)
		self:close()
	end
end

return RankRaceMatchSuccView

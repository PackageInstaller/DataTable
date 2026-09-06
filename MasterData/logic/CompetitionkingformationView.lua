-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingformationView.lua

module("logic.extensions.competitionking.view.CompetitionkingformationView", package.seeall)

local CompetitionkingformationView = class("CompetitionkingformationView", ViewComponent)

function CompetitionkingformationView:ctor()
	CompetitionkingformationView.super.ctor(self)
end

function CompetitionkingformationView:unbindEvents()
	CompetitionkingformationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)

	for i = 1, #self._petPos do
		GameUtil.rmClickHandler(self._petPos[i].btn)
	end
end

function CompetitionkingformationView:bindEvents()
	CompetitionkingformationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump2, self)
end

function CompetitionkingformationView:buildUI()
	CompetitionkingformationView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnJump1 = self:getBtn("jump_1/btnJump")
	self._btnJump2 = self:getBtn("jump_2/btnJump")
	self._petPos = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = self:getGo("formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		petPosCell.btn = goutil.findChildButtonComponent(petPosCell.go, "con")
		self._petPos[i] = petPosCell

		GameUtil.SetActive(petPosCell.go, false)
	end
end

function CompetitionkingformationView:onExit()
	CompetitionkingformationView.super.onExit(self)

	for i = 1, #self._petPos do
		uGuiUtil.clearImage(self._petPos[i].con)
	end
end

function CompetitionkingformationView:onEnter()
	CompetitionkingformationView.super.onEnter(self)

	local params = self:getOpenParam()

	if #params < 1 then
		return
	end

	self._activityId = CompetitionKingController.instance:getActivityId()
	self._activityType = CompetitionKingController.instance:getActivityType()
	self._cfgs = XiaonuoBirthConfig.instance:getFullMissionCfgById(checkint(params[1]))

	for i, v in ipairs(self._cfgs) do
		local cellCfg = self._cfgs[i]

		if cellCfg.posId > 0 then
			GameUtil.SetActive(self._petPos[cellCfg.posId].go, true)

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(cellCfg.showRaceId))

			uGuiUtil.setSpriteToImage(self._petPos[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			GameUtil.addClickHandler(self._petPos[cellCfg.posId].btn, function()
				self:_onClickGoto(cellCfg)
			end, self)
		end
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
end

function CompetitionkingformationView:_onClickJump1()
	GotoMgr.gotoByString("func#19")
end

function CompetitionkingformationView:_onClickJump2()
	GotoMgr.gotoByString("func#729")
end

function CompetitionkingformationView:_onClickGoto(data)
	local jumpTo = data and data.jumpTo

	if not string.nilorempty(jumpTo) then
		GotoMgr.gotoByString(jumpTo)
	end
end

return CompetitionkingformationView

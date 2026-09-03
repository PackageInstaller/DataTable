-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/team/view/MainTeamMediator.lua

require("dm.gameplay.team.view.BaseTeamMediator")

MainTeamMediator = class("MainTeamMediator", BaseTeamMediator, _M)

function MainTeamMediator:initialize()
	super.initialize(self)
end

function MainTeamMediator:onRegister()
	super.onRegister(self)
end

function MainTeamMediator:enterWithData(data)
	data = data or {}
	self._data = data

	self:setupTopInfoWidget()
end

function MainTeamMediator:resumeWithData()
	super.resumeWithData(self)
end

function BaseTeamMediator:saveTeam()
	local function func()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("exit_stageTeam_view")
		self:dispatch(Event:new(EVT_REFRESH_SPVIEW))
	end

	if self:checkToExit(func, false, "Stage_Team_UI10") then
		func()
	end
end

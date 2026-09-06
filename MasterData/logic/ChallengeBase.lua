-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/ChallengeBase.lua

module("logic.extensions.challenge.view.ChallengeBase", package.seeall)

local json = require("cjson")
local ChallengeBase = class("ChallengeBase", ChallengeLoadBase)

function ChallengeBase:onEnter(go, cfg, paramTable)
	self.mainGO = go
	self.cfg = cfg
	self._params = paramTable
	self._challengeId = ChallengeModel.instance:getCurId()

	self:buildUI()
	self:bindEvents()
	ChallengeBase.super.onEnter(self, go)
end

function ChallengeBase:onExit()
	self:unbindEvents()
	ChallengeBase.super.onExit(self)
end

function ChallengeBase:buildUI()
	return
end

function ChallengeBase:bindEvents()
	return
end

function ChallengeBase:unbindEvents()
	return
end

function ChallengeBase:getGo(goPath)
	return goutil.findChild(self.mainGO, goPath)
end

function ChallengeBase:getBtn(goPath)
	return Framework.ButtonAdapter.GetFrom(self.mainGO, goPath)
end

function ChallengeBase:_getExtJsonParams()
	return (json.decode(ChallengeModel.instance:getExtJsonParams()))
end

function ChallengeBase:teamFightEnd()
	return
end

function ChallengeBase:_onChallengeExtParamUpdate()
	return
end

return ChallengeBase

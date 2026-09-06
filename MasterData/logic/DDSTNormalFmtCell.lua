-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DDSTNormalFmtCell.lua

module("logic.extensions.divinedishitianclg.view.DDSTNormalFmtCell", package.seeall)

local DDSTNormalFmtCell = class("DDSTNormalFmtCell")

function DDSTNormalFmtCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtAttr = goutil.findChildTextComponent(go, "attr/txt")
	self._attrSpriteChange = goutil.findChildComponent(go, "attr/icon", ComponentType.UIImageSpriteChange)
	self._txtJob = goutil.findChildTextComponent(go, "job/txt")
	self._jobSpriteChange = goutil.findChildComponent(go, "job/icon", ComponentType.UIImageSpriteChange)
end

function DDSTNormalFmtCell:init(raceTypeId, jobId)
	self._txtAttr.text = ConstString.RaceIdToTxt[raceTypeId]

	self._attrSpriteChange:SetState(raceTypeId - 1)

	self._txtJob.text = ConstString.JobIdxToStr[jobId]

	self._jobSpriteChange:SetState(jobId - 1)
end

return DDSTNormalFmtCell

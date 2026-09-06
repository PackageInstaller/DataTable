-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/view/SYWJLLevelCell.lua

module("logic.extensions.divineasheslessdragon.view.SYWJLLevelCell", package.seeall)

local SYWJLLevelCell = class("SYWJLLevelCell")

function SYWJLLevelCell:ctor(luaComponentContainer)
	self.mainGO = luaComponentContainer.gameObject
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "btnChallenge/txtLevel")
	self._passed = goutil.findChild(self.mainGO, "pass")
	self._selectGo = goutil.findChild(self.mainGO, "select")
	self._btnClick = Framework.ButtonAdapter.GetFrom(self.mainGO, "btnChallenge")

	self._btnClick:AddClickListener(self._onClick, self)
end

function SYWJLLevelCell:init(param)
	self._index = param.index
	self._isSelect = param.isSelect
	self._activityId = param.activityId
	self._txtLevel.text = string.format("第%d关", self._index)

	goutil.setActive(self._selectGo, self._isSelect)
	goutil.setActive(self._passed, DivineasheslessdragonModel.instance:getPassedStageId(self._activityId) >= self._index)
end

function SYWJLLevelCell:reset()
	return
end

function SYWJLLevelCell:getIndex()
	return self._index
end

function SYWJLLevelCell:setSelectState(curSelectIndex)
	self._isSelect = curSelectIndex == self._index

	goutil.setActive(self._selectGo, self._isSelect)
end

function SYWJLLevelCell:_onClick()
	GlobalDispatcher:dispatch(GlobalNotify.DivineAsheslessDragonSelectLevel, self._index)
end

return SYWJLLevelCell

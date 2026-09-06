-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LYSQLevelCell.lua

module("logic.extensions.godlongyan.view.LYSQLevelCell", package.seeall)

local LYSQLevelCell = class("LYSQLevelCell")

function LYSQLevelCell:ctor(luaComponentContainer)
	self.mainGO = luaComponentContainer.gameObject
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "btnChallenge/txtLevel")
	self._passed = goutil.findChild(self.mainGO, "btnChallenge/passed")
	self._selectGo = goutil.findChild(self.mainGO, "select")
	self._btnClick = Framework.ButtonAdapter.GetFrom(self.mainGO, "btnChallenge")

	self._btnClick:AddClickListener(self._onClick, self)
end

function LYSQLevelCell:init(param)
	self._index = param.index
	self._levelCfg = param.levelCfg
	self._isSelect = param.isSelect
	self._txtLevel.text = string.format("第%d关", self._index)

	goutil.setActive(self._selectGo, self._isSelect)
	goutil.setActive(self._passed, GodLongYanModel.instance:getCurStage() >= self._index)
end

function LYSQLevelCell:reset()
	return
end

function LYSQLevelCell:getIndex()
	return self._index
end

function LYSQLevelCell:setSelectState(curSelectIndex)
	self._isSelect = curSelectIndex == self._index

	goutil.setActive(self._selectGo, self._isSelect)
end

function LYSQLevelCell:_onClick()
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanSelectLevel, self._index)
end

return LYSQLevelCell

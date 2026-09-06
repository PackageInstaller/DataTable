-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshRankItem.lua

module("logic.extensions.projectash.view.ProjectAshRankItem", package.seeall)

local ProjectAshRankItem = class("ProjectAshRankItem")

function ProjectAshRankItem:ctor(luaComponentContainer)
	local mainGo = luaComponentContainer.gameObject

	self._txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	self._imgRank = goutil.findChild(mainGo, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	self._head = goutil.findChild(mainGo, "head")
	self._txtName = goutil.findChildTextComponent(mainGo, "txt1")
	self._txtScore = goutil.findChildTextComponent(mainGo, "txt2")
	self._cell = goutil.findChild(mainGo, "tableview/item")
	self._tableview = goutil.findChild(mainGo, "tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ProjectAshRankItem:init(data, activityId)
	if data.rank >= 1 and data.rank <= 3 then
		goutil.setActive(self._txtRank.gameObject, false)
		goutil.setActive(self._imgRank.gameObject, true)

		self._txtRank.text = ""

		self._imgRank:SetState(data.rank - 1)
	else
		goutil.setActive(self._txtRank.gameObject, true)
		goutil.setActive(self._imgRank.gameObject, false)

		self._txtRank.text = data.rank
	end

	MaterialMgr.resetAll(self._head)
	HeadItemController.instance:setHeadCellByInfo(self._head, data.headInfo)

	self._txtName.text = data.headInfo.userName
	self._txtScore.text = data.value

	local list = ProjectAshController.instance:getMyRewardStrList(data.rank, activityId)

	self._scrollList:reloadData(list)
end

function ProjectAshRankItem:reset()
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._head)
end

function ProjectAshRankItem:_updateCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function ProjectAshRankItem:_clearCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll()
end

return ProjectAshRankItem

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestJoinView.lua

module("logic.extensions.goddesscontest.view.GoddessContestJoinView", package.seeall)

local GoddessContestJoinView = class("GoddessContestJoinView", ViewComponent)

function GoddessContestJoinView:buildUI()
	GoddessContestJoinView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._groupCell = self:getGo("groupCom/groupCell")
	self._groupView = self:getGo("groupCom/groupView")

	goutil.setActive(self._groupCell, false)
end

function GoddessContestJoinView:bindEvents()
	GoddessContestJoinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddessContestJoinView:unbindEvents()
	GoddessContestJoinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessContestJoinView:onEnter()
	GoddessContestJoinView.super.onEnter(self)

	self._curActId = GoddessContestModel.instance:getCurActId()
	self._groupCfgs = GoddessContestConfig.instance:getFanGroupCfgsByActId(self._curActId)

	self:_refreshView()
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestSucJoinGroup, self._onJoinGroup, self)
end

function GoddessContestJoinView:onExit()
	GoddessContestJoinView.super.onExit(self)

	for k, v in pairs(self._groupCellList) do
		for k1, v1 in ipairs(GameUtil.getChildren(v.petView)) do
			MaterialMgr.resetAll(v1)
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestSucJoinGroup, self._onJoinGroup, self)
end

function GoddessContestJoinView:_refreshView()
	self._groupCellList = {}

	for id, cfg in ipairs(self._groupCfgs) do
		self._groupCellList[id] = self:_getGroupCell(id)

		self:_refreshCell(id)
	end
end

function GoddessContestJoinView:_getGroupCell(id)
	local cell = {}

	cell.go = goutil.findChild(self._groupView, "cell_" .. id) or goutil.cloneAndSetParent(self._groupCell, self._groupView.transform, "cell_" .. id)
	cell.txtNumMembers = goutil.findChildTextComponent(cell.go, "peopleNum/txtNum")
	cell.icon = goutil.findChildComponent(cell.go, "title/icon", "UIImageSpriteChange")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txtTitle")
	cell.petView = goutil.findChild(cell.go, "petCom/petView")
	cell.petCell = goutil.findChild(cell.go, "petCom/petCell")

	goutil.setActive(cell.petCell, false)

	cell.btnAdd = goutil.findChild(cell.go, "btnAdd")
	cell.txtAdd = goutil.findChildTextComponent(cell.btnAdd, "txt")

	GameUtil.rmClickHandler(cell.btnAdd)
	goutil.setActive(cell.go, false)

	return cell
end

function GoddessContestJoinView:_refreshCell(id)
	local cell = self._groupCellList[id]

	cell.cfg = self._groupCfgs[id]
	cell.data = GoddessContestModel.instance:getFansGroupInfo(id)
	cell.txtAdd.text = lang("加入粉丝团")

	if cell.data then
		if not cell.data.numMembers then
			local curNumMember = 0

			if cell.cfg then
				cell.curAbleJoinNum = cell.cfg.proactiveNums - curNumMember
				cell.txtNumMembers.text = langPara("手动入团人数：%s/%s", curNumMember, cell.cfg.proactiveNums)

				cell.icon:SetState(id - 1)

				cell.txtTitle.text = cell.cfg.fansGroupName

				goutil.setActive(cell.go, true)
				GameUtil.addClickHandler(cell.btnAdd, GameUtil.handler(self._onClickJoin, self, id))

				local skinChildren = GameUtil.getChildren(cell.petView)

				for _, v in ipairs(skinChildren) do
					MaterialMgr.resetAll(v)
					goutil.setActive(v, false)
				end

				for i = 1, table.nums(cell.cfg.fansGroupGoddess) do
					local skinCell = goutil.findChild(cell.petView, "cell_" .. i)

					skinCell = skinCell or goutil.cloneAndSetParent(cell.petCell, cell.petView.transform, "cell_" .. i)

					MaterialMgr.setCell(MatType.PET_SKIN, cell.cfg.fansGroupGoddess[i], skinCell)
					goutil.setActive(skinCell, true)
				end

				if cell.curAbleJoinNum <= 0 then
					cell.txtAdd.text = lang("已满员")
				end
			end
		end
	end
end

function GoddessContestJoinView:_onClickJoin(id)
	local cell = self._groupCellList[id]

	if cell and checkint(cell.curAbleJoinNum) > 0 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认加入该粉丝团，加入后本次活动期间不可更改"), function()
			GoddessContestController.instance:joinFansGroup(id)
		end)
	else
		FloatWordMgr.instance:show("该组团队人数已达上限！")
	end
end

function GoddessContestJoinView:_onError(status)
	return
end

function GoddessContestJoinView:_onJoinGroup()
	self:close()
	UIStateManager.instance:push(ViewName.GoddessContestMainView)
end

return GoddessContestJoinView

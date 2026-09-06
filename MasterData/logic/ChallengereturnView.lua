-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/ChallengereturnView.lua

module("logic.extensions.bonus.view.christmasandnewyear.ChallengereturnView", package.seeall)

local ChallengereturnView = class("ChallengereturnView", SummarySubTabView)

function ChallengereturnView:ctor()
	ChallengereturnView.super.ctor(self)
end

function ChallengereturnView:init()
	ChallengereturnView.super.init(self)

	self.petIdCfg = checknumber(self._cfgs[1].background)
end

function ChallengereturnView:unbindEvents()
	ChallengereturnView.super.unbindEvents(self)
end

function ChallengereturnView:bindEvents()
	ChallengereturnView.super.bindEvents(self)
end

function ChallengereturnView:buildUI()
	ChallengereturnView.super.buildUI(self)

	self.TableView = self:getGo("tableview")
	self.Cell = self:getGo("cell")
	self.tableview = ScrollerList.create(self.TableView, self.Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._con = self:getGo("con")
end

function ChallengereturnView:onExit()
	self.role = RoleObjectPool.instance:removeRole(self.role)

	self.tableview:dispose()
	ChallengereturnView.super.onExit(self)
end

function ChallengereturnView:onEnter()
	ChallengereturnView.super.onEnter(self)
	self.tableview:reloadData(self._cfgs)
	self:updateUI()
end

function ChallengereturnView:_updateCell(view, cell, data)
	local paramsArr = string.split(data.params, "#")
	local isEnd = data.id >= 4
	local goBtn = goutil.findChild(cell, "btnGoto")
	local txtGoBtn = goutil.findChildTextComponent(goBtn, "Text")

	GameUtil.addClickHandler(goBtn, GameUtil.handler(self._onJump, self, data))

	if isEnd then
		GameUtil.setBtnState(goBtn, txtGoBtn, true)
	else
		GameUtil.setBtnState(goBtn, txtGoBtn, false)
	end

	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	txtDesc.text = paramsArr[1]
	txtScore.text = paramsArr[2]

	local tag = goutil.findChild(cell, "end")

	goutil.setActive(tag, isEnd)
end

function ChallengereturnView:_clearCell(cell)
	local goBtn = goutil.findChild(cell, "btnGoto")

	GameUtil.rmClickHandler(goBtn)
end

function ChallengereturnView:updateUI()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(self.petIdCfg)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self.role = RoleObjectPool.instance:addRoleToParent(self.role, self.petIdCfg, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function ChallengereturnView:buildBtnJump()
	return
end

return ChallengereturnView

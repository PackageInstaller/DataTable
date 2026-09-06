-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticetaskView.lua

module("logic.extensions.upholdjustice.view.UpholdjusticetaskView", package.seeall)

local UpholdjusticetaskView = class("UpholdjusticetaskView", CommonGroupTaskMainView)

function UpholdjusticetaskView:ctor()
	UpholdjusticetaskView.super.ctor(self)
end

function UpholdjusticetaskView:unbindEvents()
	UpholdjusticetaskView.super.unbindEvents(self)
end

function UpholdjusticetaskView:bindEvents()
	UpholdjusticetaskView.super.bindEvents(self)
end

function UpholdjusticetaskView:buildUI()
	UpholdjusticetaskView.super.buildUI(self)

	self._con = self:getGo("con")

	self._tabScrollList:setCenterMode(true)
end

function UpholdjusticetaskView:onExit()
	UpholdjusticetaskView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function UpholdjusticetaskView:onEnter()
	UpholdjusticetaskView.super.onEnter(self)

	local cfg = UpholdJusticConfig.instance:getActCfgById(self._activityId) or {}
	local skinId = cfg.skinId

	if skinId then
		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)
				end
			end
		end
	end
end

function UpholdjusticetaskView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local select = goutil.findChild(mainGo, "select")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtName2 = goutil.findChildTextComponent(mainGo, "select/txtName")

	txtName.text = data.pageName
	txtName2.text = data.pageName

	self:_setIsCellRed(cell, data)
	GameUtil.SetActive(select, self._curTabIdx == tabIdx)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

return UpholdjusticetaskView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachleveltipView.lua

module("logic.extensions.teachingdungeon.view.TeachleveltipView", package.seeall)

local TeachleveltipView = class("TeachleveltipView", ViewComponent)

function TeachleveltipView:ctor()
	TeachleveltipView.super.ctor(self)
end

function TeachleveltipView:buildUI()
	TeachleveltipView.super.buildUI(self)

	self.okBtn = self:getBtn("okBtn")
end

function TeachleveltipView:bindEvents()
	TeachleveltipView.super.bindEvents(self)
end

function TeachleveltipView:unbindEvents()
	TeachleveltipView.super.unbindEvents(self)
end

function TeachleveltipView:destroyUI()
	TeachleveltipView.super.destroyUI(self)
end

function TeachleveltipView:onEnter()
	TeachleveltipView.super.onEnter(self)
	self.okBtn:AddClickListener(self.onClickOk, self)
end

function TeachleveltipView:onEnterFinished()
	TeachleveltipView.super.onEnterFinished(self)
	Framework.TransformUtil.SetLocalPos(self.mainGO.transform, 0, -24, 0)
end

function TeachleveltipView:onExit()
	TeachleveltipView.super.onExit(self)
	self.okBtn:RemoveClickListener()
	self.mainGO:SetActive(false)
end

function TeachleveltipView:onExitFinished()
	TeachleveltipView.super.onExitFinished(self)
end

function TeachleveltipView:onClickOk()
	local cfg = TeachingDungeonConfig.instance:getMonsterCfg()

	if cfg then
		if not cfg.description then
			UIStateManager.instance:push(ViewName.TeachingDungeonTip, {
				tag = 1,
				stageId = TeachingDungeonModel.instance:getCurrStageId()
			})
		end
	end
end

return TeachleveltipView

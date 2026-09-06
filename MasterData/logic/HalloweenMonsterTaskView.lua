-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenMonsterTaskView.lua

module("logic.extensions.halloweenguest.view.HalloweenMonsterTaskView", package.seeall)

local HalloweenMonsterTaskView = class("HalloweenMonsterTaskView", TableViewComponent)

function HalloweenMonsterTaskView:ctor()
	HalloweenMonsterTaskView.super.ctor(self)

	self._curViewDatas = nil
end

function HalloweenMonsterTaskView:bindEvents()
	HalloweenMonsterTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function HalloweenMonsterTaskView:unbindEvents()
	HalloweenMonsterTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function HalloweenMonsterTaskView:onExit()
	HalloweenMonsterTaskView.super.onExit(self)

	self._curViewDatas = nil
end

function HalloweenMonsterTaskView:destroyUI()
	HalloweenMonsterTaskView.super.destroyUI(self)
end

function HalloweenMonsterTaskView:buildUI()
	HalloweenMonsterTaskView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function HalloweenMonsterTaskView:onEnter()
	HalloweenMonsterTaskView.super.onEnter(self)

	self._curViewDatas = HalloweenGuestModel.instance:getAllSceneMonsters()

	self._tableview:ReloadData()
end

function HalloweenMonsterTaskView:_getPath()
	return {
		cellPath = "taskItem",
		viewPath = "taskItemSR"
	}
end

function HalloweenMonsterTaskView:_cellSize()
	return 458, 104
end

function HalloweenMonsterTaskView:_updateCell(view, cell, data)
	local iconImaGo = goutil.findChild(cell, "iconIma")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")
	local gotoBtnGo = goutil.findChild(cell, "gotoBtn")

	MaterialMgr.clearIcon(iconImaGo)
	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()

	local sceneCfg = HalloweenGuestConfig.instance:getHalloweenSceneCfg(data.planId, data.scId)

	if sceneCfg then
		local cfg = SceneConfig.instance:getSceneCo(sceneCfg.sceneId or 1001)

		if cfg then
			if not cfg.showImage then
				local iconName = "aoqicheng"

				uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl(iconName))

				if sceneCfg then
					local posCfg = HalloweenGuestConfig.instance:getHalloweenMonsterCfg(sceneCfg.scenePositionPlanId or 1, data.posId)

					nameTxt.text = posCfg.desc

					receiveGo:SetActive(data.isChall)
					GameUtil.SetActive(gotoBtnGo, not data.isChall)

					if data.isChall then
						return
					end

					GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
						if checknumber(posCfg.npcId) <= 0 then
							return
						end

						GotoMgr.gotoByString("npc#" .. posCfg.npcId)
					end, self)
				end
			end
		end
	end
end

return HalloweenMonsterTaskView

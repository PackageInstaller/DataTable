-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossRewardView.lua

module("logic.extensions.worldboss.view.WorldBossRewardView", package.seeall)

local WorldBossRewardView = class("WorldBossRewardView", TableViewComponent)

function WorldBossRewardView:ctor()
	WorldBossRewardView.super.ctor(self)
end

function WorldBossRewardView:buildUI()
	WorldBossRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function WorldBossRewardView:bindEvents()
	WorldBossRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function WorldBossRewardView:unbindEvents()
	WorldBossRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function WorldBossRewardView:destroyUI()
	WorldBossRewardView.super.destroyUI(self)
end

function WorldBossRewardView:onEnter()
	WorldBossRewardView.super.onEnter(self)

	self._curViewDatas = WorldBossController.instance:getWorldBossRankPrize()

	self._tableview:ReloadData()
end

function WorldBossRewardView:onEnterFinished()
	WorldBossRewardView.super.onEnterFinished(self)
end

function WorldBossRewardView:onExit()
	WorldBossRewardView.super.onExit(self)

	self._curViewDatas = nil
end

function WorldBossRewardView:onExitFinished()
	WorldBossRewardView.super.onExitFinished(self)
end

function WorldBossRewardView:_onClickBtnClose()
	self:close()
end

function WorldBossRewardView:_getPath()
	return {
		cellPath = "tabView/sv_item",
		viewPath = "tabView/sv_info"
	}
end

function WorldBossRewardView:_cellSize()
	return 740, 180
end

function WorldBossRewardView:_updateCell(view, cell, data)
	local _txtTitle = goutil.findChildComponent(cell.gameObject, "bk/txtRank", "Text")

	_txtTitle.text = data.endRank ~= 1 and string.format(lang("world_Boss_tip11"), data.startRank, data.endRank) or lang("world_Boss_tip10")

	local _prizeArray = string.split(data.prize, "#")

	if _prizeArray then
		for i = 1, 4 do
			local _item = goutil.findChild(cell.gameObject, "bk/gridItem/item_" .. i)

			if i <= #_prizeArray then
				_item.gameObject:SetActive(true)
				MaterialMgr.resetAll(_item)

				if _prizeArray[i] and _prizeArray[i] ~= "" then
					local proxy = MaterialMgr.setCellByCfg(_prizeArray[i], _item)

					Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
				end
			else
				_item.gameObject:SetActive(false)
			end
		end
	end
end

return WorldBossRewardView

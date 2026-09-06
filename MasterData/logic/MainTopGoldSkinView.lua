-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/MainTopGoldSkinView.lua

module("logic.extensions.roleinfo.view.MainTopGoldSkinView", package.seeall)

local MainTopGoldSkinView = class("MainTopGoldSkinView", MainTopGoldView)

function MainTopGoldSkinView:ctor()
	MainTopGoldSkinView.super.ctor(self)
end

function MainTopGoldSkinView:destroyUI()
	MainTopGoldView.super.destroyUI(self)

	self._itemGroup = nil
end

function MainTopGoldSkinView:unbindEvents()
	MainTopGoldSkinView.super.unbindEvents(self)
end

function MainTopGoldSkinView:bindEvents()
	MainTopGoldSkinView.super.bindEvents(self)
end

function MainTopGoldSkinView:buildUI()
	MainTopGoldSkinView.super.buildUI(self)
end

function MainTopGoldSkinView:onExit()
	MainTopGoldSkinView.super.onExit(self)
end

function MainTopGoldSkinView:onEnter()
	MainTopGoldSkinView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.UpdateExterior, self._updateItem, self)
end

function MainTopGoldSkinView:_updateItem()
	if self.itemDataList then
		local function updateItem(item, data)
			local function callBack()
				if data.obj.showAdd then
					if data.obj.showAddCallBack then
						data.obj.showAddCallBack()
					else
						self:_onClickAddBtn(data.obj.id, data.matStr, item.mainGO)
					end
				end
			end

			local function callbackOnClickItemIcon()
				self:_onClickItemIcon(data.matStr, item.mainGO)
			end

			local component = MainTopGoldItem.AddOnce(item.mainGO)
			local typeId = data.obj.id
			local txt = self:_getItemText(typeId, data.matStr, data.obj.params)
			local spriteType, iconUrl = self:_getItemIcon(typeId, data.matStr)
			local addBtnActive = data.obj.showAdd
			local skinId = ExteriorController.instance:getExteriorCfg().id

			component:setSkin(skinId)
			component:setData(item.index, typeId, txt, spriteType, iconUrl, addBtnActive, callBack, callbackOnClickItemIcon)
		end

		self._itemGroup:updateWithMoArray(self.itemDataList, updateItem)
	end
end

return MainTopGoldSkinView

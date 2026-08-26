-- chunkname: @modules/logic/survival/view/role/item/SurvivalRoleSelectItem.lua

module("modules.logic.survival.view.role.item.SurvivalRoleSelectItem", package.seeall)

local SurvivalRoleSelectItem = class("SurvivalRoleSelectItem", SimpleListItem)

function SurvivalRoleSelectItem:onInit()
	self.imgPicture = gohelper.findChildSingleImage(self.viewGO, "#go_normal")
	self.imgPicture2 = gohelper.findChildImage(self.viewGO, "#go_normal")
	self.textName = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self.lock = gohelper.findChild(self.viewGO, "#go_lock")
	self.animLock = self.lock:GetComponent(gohelper.Type_Animator)
	self.selectNode = gohelper.findChild(self.viewGO, "#Image_select")
	self.go_finish = gohelper.findChild(self.viewGO, "#go_finish")
	self.survivalOutSideRoleModel = SurvivalModel.instance:getOutSideInfo().survivalOutSideRoleMo

	gohelper.setActive(self.selectNode, false)
end

function SurvivalRoleSelectItem:onAddListeners()
	return
end

function SurvivalRoleSelectItem:onRemoveListeners()
	return
end

function SurvivalRoleSelectItem:onDestroy()
	self.imgPicture:UnLoadImage()
end

function SurvivalRoleSelectItem:onItemShow(data)
	self.cfg = data.cfg
	self.context = data.context
	self.isLock = self.survivalOutSideRoleModel:isRoleLock(self.cfg.id)
	self.isUnLockFuture = self.survivalOutSideRoleModel:isUnLockFuture(self.cfg.id)

	if self.isLock then
		local isShowLock = not self.isUnLockFuture

		if self.isUnLockFuture then
			gohelper.setActive(self.lock, false)
		elseif isShowLock then
			gohelper.setActive(self.lock, true)
			self.animLock:Play("lock", 0, 0)
		else
			local survivalRole = self.survivalOutSideRoleModel:getSurvivalRole(self.cfg.id)
			local isNew = survivalRole.isNew

			if isNew then
				self.animLock:Play("unlock", 0, 0)
			else
				gohelper.setActive(self.lock, false)
			end
		end

		if isShowLock then
			self.textName.alpha = 0.5

			ZProj.UGUIHelper.SetColorAlpha(self.imgPicture2, 0.5)
		else
			self.textName.alpha = 1

			ZProj.UGUIHelper.SetColorAlpha(self.imgPicture2, 1)
		end

		self.textName.text = self.isUnLockFuture and "???" or self.cfg.name

		if self.isUnLockFuture then
			SurvivalUnitIconHelper.instance:setNpcIcon(self.imgPicture, "chess_img_unknown")
		else
			local cardPath = SurvivalRoleConfig.instance:getRoleChessImage(self.cfg.id)

			if not string.nilorempty(cardPath) then
				SurvivalUnitIconHelper.instance:setNpcIcon(self.imgPicture, cardPath)
			end
		end

		local isStory = SurvivalDifficultyModel.instance:isStoryDifficulty()
		local outSideInfo = SurvivalModel.instance:getOutSideInfo()
		local isShowFinish = false

		if self.cfg.id == 1 then
			isShowFinish = isStory and outSideInfo:isEndUnLock(3001)
		elseif self.cfg.id == 2 then
			isShowFinish = isStory and outSideInfo:isEndUnLock(3002)
		end

		gohelper.setActive(self.go_finish, isShowFinish)
	end
end

function SurvivalRoleSelectItem:onSelectChange(isSelect)
	gohelper.setActive(self.selectNode, isSelect)
end

return SurvivalRoleSelectItem

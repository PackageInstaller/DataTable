-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\AvgRoleFrame.lua

local AnimatorType = typeof(UnityEngine.Animator)
local strClassName = "AvgRoleFrame"
local AvgRoleFrame = Class(strClassName, UIControls.Child)

function AvgRoleFrame:ctor(...)
	self:initUI()
end

function AvgRoleFrame:initUI(...)
	local go = self:getController().gameObject

	self.roleAnimator = go:GetComponent(AnimatorType)

	local SpriteRendererType = typeof(UnityEngine.SpriteRenderer)

	self.roleRender = go:GetComponent(SpriteRendererType)
	self.rootPanel = UIControls.Panel(self, "")
end

function AvgRoleFrame:showHeroByAnimator(heroId)
	if self.roleAnimator then
		self.roleAnimator:Play(heroId, -1, 0)

		local uiInfo

		if UIManager.lastAvgIsNewbie then
			uiInfo = UIConst.UIMap.newbieTalkDlg
		else
			uiInfo = UIConst.UIMap.talkBox
		end

		if uiInfo and uiInfo.ui_order then
			self.roleRender.sortingOrder = uiInfo.ui_order + 3
		end
	end
end

function AvgRoleFrame:setScale(scale)
	local absScale = math.abs(scale)

	self.rootPanel:setScaleXYZ(scale, absScale, absScale)
end

return AvgRoleFrame

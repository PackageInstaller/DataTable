-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\PettyPayTipsPanel.lua

local ResPettyPayTab = require("ClientData/ResPettyPayTab")
local strClassName = "PettyPayTipsPanel"
local PettyPayTipsPanel = Class(strClassName, UIControls.Panel)

function PettyPayTipsPanel:ctor(...)
	self:initUI()
end

function PettyPayTipsPanel:initUI(...)
	self.iconNew = UIControls.Image(self, self.mPath .. "/IconNew")
	self.enterBtn = UIControls.Button(self, self.mPath)

	self.enterBtn:addEventClick(self.onenterBtnClick)
	self:refreshUI()
end

function PettyPayTipsPanel:onenterBtnClick(...)
	local ui = UIManager.getUI("activityPettyPayDlg", true, true)

	if ui then
		ui:setData()
	end
end

function PettyPayTipsPanel:refreshUI(...)
	if CurAvatar:petPettySystemEnable() == true then
		self:show(true)
	else
		self:show(false)
	end

	self:checkNew()
end

local function stringSplitTonumber(longString)
	local splittedData = utils.splitString(tostring(longString), ",")

	for index = 1, #splittedData do
		splittedData[index] = tonumber(splittedData[index])
	end

	return splittedData
end

function PettyPayTipsPanel:checkNew(...)
	local flag = false

	for _, value in pairs(ResPettyPayTab) do
		if value.templ_id then
			local templID = value.templ_id
			local actObj

			for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
				if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
					actObj = activityObj
				end
			end

			if actObj and actObj.actData and actObj.actData.checkNew then
				flag = actObj.actData:checkNew()
			end

			if flag == true then
				break
			end
		end

		if value.rela_templ_id then
			local data = stringSplitTonumber(value.rela_templ_id)

			for k, v in pairs(data) do
				local templID = v
				local actObj

				for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
					if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
						actObj = activityObj
					end
				end

				if actObj and actObj.actData and actObj.actData.checkNew then
					flag = actObj.actData:checkNew()
				end

				if flag == true then
					break
				end
			end
		end
	end

	self.iconNew:setVisible(flag)
end

function PettyPayTipsPanel:show(ishow)
	self:setVisible(ishow)
end

return PettyPayTipsPanel

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\PettyPay30DaysSignInPanel.lua

local strClassName = "PettyPay30DaysSignInPanel"
local PettyPay30DaysSignInPanel = Class(strClassName, UIControls.Panel)

function PettyPay30DaysSignInPanel:ctor(...)
	self:initUI()
end

function PettyPay30DaysSignInPanel:initUI(...)
	self.btnEnter = UIControls.Button(self, self.mPath)

	self.btnEnter:addEventClick(self.onBtnEnterClick)

	self.txt = UIControls.Label(self, self.mPath .. "/ImgSignIn/Text")
	self.iconNew = UIControls.Image(self, self.mPath .. "/IconNew")

	self:refreshUI()
end

function PettyPay30DaysSignInPanel:setResData(resData)
	self.resData = resData

	if self.resData then
		local templID = self.resData.templ_id

		if templID then
			local actObj

			for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
				if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
					actObj = activityObj
				end

				if actObj then
					self.actObj = actObj
				end
			end
		end

		if self.actObj then
			self.actData = self.actObj.actData

			if self.actData then
				self.templateData = self.actObj.templateData
				self.serverData = self.actData.serverData
				self.clientData = self.actData.clientData
			end
		end
	end

	self:refreshUI()
end

local constSignInAchieveType = 113

function PettyPay30DaysSignInPanel:refreshUI()
	if self.resData then
		-- block empty
	end

	local param = 30

	if self.clientData and self.clientData[constSignInAchieveType] then
		param = #self.clientData[constSignInAchieveType]
	end

	local progress = 0

	if self.serverData and self.serverData[constSignInAchieveType] and self.serverData[constSignInAchieveType].progress then
		progress = self.serverData[constSignInAchieveType].progress
	end

	self.txt:setText(utils.format(Lang.get(89892), progress, param))
	self:checkRedDot()
end

local function stringSplitTonumber(longString)
	local splittedData = utils.splitString(tostring(longString), ",")

	for index = 1, #splittedData do
		splittedData[index] = tonumber(splittedData[index])
	end

	return splittedData
end

function PettyPay30DaysSignInPanel:checkRedDot()
	if self.resData then
		local showFlag = false

		if self.resData.templ_id then
			local templID = self.resData.templ_id
			local actObj

			for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
				if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
					actObj = activityObj
				end
			end

			if actObj and actObj.actData and actObj.actData.checkNew then
				showFlag = actObj.actData:checkNew()
			end
		end

		if self.resData.rela_templ_id and not showFlag then
			local data = stringSplitTonumber(self.resData.rela_templ_id)

			for k, v in pairs(data) do
				local templID = v
				local actObj

				for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
					if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
						actObj = activityObj
					end
				end

				if actObj and actObj.actData and actObj.actData.checkNew then
					showFlag = actObj.actData:checkNew()
				end

				if showFlag == true then
					break
				end
			end
		end

		self.iconNew:setVisible(showFlag)
	end
end

function PettyPay30DaysSignInPanel:onBtnEnterClick()
	local ui = UIManager.getUI("activity30DaysSignInDlg", true)
end

return PettyPay30DaysSignInPanel

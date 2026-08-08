---@class ProtoAgreementCheck : ProtoAgreementCheck_Generate
---##################### 【ProtoAgreementCheck Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ProtoAgreementCheck Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ProtoAgreementCheck = require "ProtoAgreementCheck_Generate"
local utf8 = require "lua-utf8"

local function _setLongTextContent(template, root, content)
	local sizeSeperate = 11500
	local len = utf8.len(content)
	local pos = 1
	local contents = {}
	while pos <= len do
		if len - pos + 1 > sizeSeperate then
			local from, to = utf8.find(content, "\n", pos + sizeSeperate - 1)
			if from then
				table.insert(contents, utf8.sub(content, pos, to - 1)) -- to的位置是\n，但由于多个text通过纵向排列的时候相当于隐藏加了一个\n，所以这里到to-1（即使\n前一个字符）
				pos = to + 1
			else
				-- 说明一直找不到换行，内容太长了一般不会有这种情况，就简单处理
				table.insert(contents, utf8.sub(content, pos, pos + sizeSeperate - 1))
				pos = pos + sizeSeperate
			end
		else
			table.insert(contents, utf8.sub(content, pos))
			break
		end
	end

	self:FillTemplateContent(template, root, 0, function (idx, go)
		--go.text.text = contents[idx]
	end)

	self:FillTemplateContent(template, root, #contents, function (idx, go)
		go.text.text = contents[idx]
	end)
end

function ProtoAgreementCheck:InitLogic(data)

end

--function ProtoAgreementCheck:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/Root onValueChanged 
--]]
function ProtoAgreementCheck:toggle_Toggle_onValueChanged(toggle,isOn)
	self.isAgreementOn = isOn
	UnityEngine.PlayerPrefs.SetInt("__IsAgreeUserProtocol__", isOn and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
end

--[[
/agreement1Btn onClick 
--]]
function ProtoAgreementCheck:agreement1Btn_Button_onClick(agreement1Btn)
	Application.OpenURL("https://mby.moefantasy.com/users-protocol.html")
	--self.registerAgreement.agreementTitle.text.text = LocalStrEnum.AgreementTitleUserProtocol
	--self.scrollView.scrollRect.normalizedPosition = Vector2.New(0, 1)
	--_setLongTextContent(self.registerAgreement.agreeText, self.registerAgreement.content, LocalStrEnum.UserRegAgreement)
	----self.registerAgreement.agreeText.text.text = LocalStrEnum.UserRegAgreement
	--self.registerAgreement:SetActive(true)
end

--[[
/agreement2Btn onClick 
--]]
function ProtoAgreementCheck:agreement2Btn_Button_onClick(agreement2Btn)
	Application.OpenURL("https://mby.moefantasy.com/privacy.html")
	--self.registerAgreement.agreementTitle.text.text = LocalStrEnum.AgreementTitlePrivacy
	--self.scrollView.scrollRect.normalizedPosition = Vector2.New(0, 1)
	--_setLongTextContent(self.registerAgreement.agreeText, self.registerAgreement.content, LocalStrEnum.UserRegPrivacyContent)
	----self.registerAgreement.agreeText.text.text = LocalStrEnum.UserRegPrivacyContent
	--self.registerAgreement:SetActive(true)
end

--[[
/RegisterAgreement/okBtn onClick 
--]]
function ProtoAgreementCheck:okBtn_Button_onClick(okBtn)
	self.registerAgreement:SetActive(false)
end

return ProtoAgreementCheck

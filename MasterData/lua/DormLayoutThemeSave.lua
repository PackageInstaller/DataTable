--主题保存
function Awake()
	input = ComUtil.GetCom(InputField, "InputField")
	CSAPI.AddInputFieldChange(InputField, InputChange)
	CSAPI.AddInputFieldCallBack(InputField, InputCB)
end

function OnDestroy()
	CSAPI.RemoveInputFieldChange(InputField, InputChange)
	CSAPI.RemoveInputFieldCallBack(InputField, InputCB)
end

function OnOpen()
	
end

--取消
function OnClickClose()
	view:Close()
end

function OnClickR()
	local str = input.text
	if(StringUtil:IsEmpty(str)) then
		--Tips.ShowTips("主题名称为空")
		LanguageMgr:ShowTips(21011)
	elseif(MsgParser:CheckContain(str)) then
		--Tips.ShowTips("主题名称不可用")
		LanguageMgr:ShowTips(21012)
	else
		local furnitureDatas = DormMgr:GetChangeFurnitureDatas()
		local comfort = DormMgr:GetChangeComfort()
		local lv = DormMgr:GetCurRoomData():GetLv()
		local img = DormMgr:GetScreenshotFileName()
		DormProto:SaveTheme(str, furnitureDatas, comfort, lv, img)
		view:Close()
	end
end


function InputChange(_str)
	input.text = StringUtil:FilterChar(_str) --_str
end
function InputCB(_str)
	input.text = StringUtil:FilterChar(_str) --_str
end
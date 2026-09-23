function Refresh(_data, _roomInfo)
	data = _data
	roomInfo = _roomInfo

	isInvite = true
	--lv
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtLv, lvStr .. data:GetLv())
	--name
	CSAPI.SetText(txtName, data:GetName())
	--state
	CSAPI.SetText(txtState, data:GetOnLine())
	--btn
	local b = data:IsOnLine()
	CSAPI.SetGOActive(btnInvite, b)
	if(b) then
		local str = ""
		if(roomInfo:CheckIsIn()) then
			--已在房间
			CSAPI.SetGOActive(txtInvite2, true)
			CSAPI.SetGOActive(btnInvite, false)
		else
			CSAPI.SetGOActive(txtInvite2, false)
			CSAPI.SetGOActive(btnInvite, true)

			isInvite = roomInfo:CheckIsInvite(data.uid)
			CSAPI.SetText(txtInvite, isInvite and "已邀请" or "邀请")
			if(not canvasGroup) then
				canvasGroup = ComUtil.GetCom(btnInvite, "CanvasGroup")
			end
			canvasGroup.alpha = isInvite and 0.5 or 1
		end
	end
end

function OnClickInvite()
	if(not isInvite) then
		TeamBoss:RoomInvite(data.uid, roomInfo:GetId())
	end
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
iconBg=nil;
icon=nil;
txtLv=nil;
txtName=nil;
txtState=nil;
btnInvite=nil;
txtInvite=nil;
view=nil;
end
----#End#----
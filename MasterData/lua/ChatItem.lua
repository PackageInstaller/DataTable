--聊天子物体
local isSelf = false
local data = nil
local type = nil
local typeStr = {
	"世界",
	"系统",
	"公会",
	"组队",
	"好友"
}

function Awake()
	txtLineL = ComUtil.GetCom(txtContentL, "TextCustom")
	txtLineR = ComUtil.GetCom(txtContentR, "TextCustom")
end

function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(idx)
	index = idx
end

function Refresh(_data, elseData)
	data = _data
	type = elseData
	if(data) then
		--LogError(data)
		--pos
		isSelf = data:GetIsSelf()
		CSAPI.SetGOActive(leftNode, not isSelf)
		CSAPI.SetGOActive(rightNode, isSelf)
		SetFriendObj(ChatMgr:GetCurType() == ChatType.Friend)
		
		--icon
		local icon = isSelf and iconR or iconL
		if data:GetIconId() then
			local iconName = Cfgs.character:GetByID(data:GetIconId()).icon
			ResUtil.RoleCard:Load(icon, iconName, false)
		else
			LogError("找不到头像ID!")
		end
		
		--type
		local str = typeStr[type] or ""
		local txtType = isSelf and txtTypeR or txtTypeL
		CSAPI.SetText(txtType, str)
		
		--name
		local txtName = isSelf and txtNameR or txtNameL
		if data:GetName() then
			CSAPI.SetText(txtName, data:GetName())
		else
			LogError("找不到名字!")
		end
		
		--content
		local txtContent = isSelf and txtContentR or txtContentL
		local txtLine = isSelf and txtLineR or txtLineL
		txtLine.text = ""
		local msg = data:GetContent() or ""
		local picObj = isSelf and picR or picL
		if msg ~= "" then
			if string.sub(msg, 1, 1) == "/" then
				local strs = StringUtil:split(msg, "/")
				ResUtil:LoadFaceImg(picObj, strs[1], true)
				CSAPI.SetGOActive(picObj, true)
				CSAPI.SetRTSize(gameObject, 800, 240)
			else
				txtLine.text = msg
				CSAPI.SetRTSize(gameObject, 800, 100)
				CSAPI.SetGOActive(picObj, false)
			end
		else
			LogError("找不到内容!")
		end
		
		--time
		local txtTime = isSelf and txtTimeR or txtTimeL
		CSAPI.SetText(txtTime, data:GetTimeStr())
	end
end

--好友隐藏个别组件
function SetFriendObj(isFriend)
	local typeBg = isSelf and typeBgR or typeBgL
	CSAPI.SetGOActive(typeBg, not isFriend)
	local txtName = isSelf and txtNameR or txtNameL
	CSAPI.SetGOActive(txtName, not isFriend)
	local imgObj = isSelf and imgObjR or imgObjL
	CSAPI.SetGOActive(imgObj, not isFriend)
end

function GetUid()
	return data and data:GetUid()
end

function GetName()
	return data and data:GetName()
end

function OnClick()
	if(cb) then
		cb(this)
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
leftNode=nil;
iconL=nil;
imgObjL=nil;
typeBgL=nil;
txtTypeL=nil;
txtNameL=nil;
txtContentL=nil;
picL=nil;
txtTimeL=nil;
rightNode=nil;
imgObjR=nil;
typeBgR=nil;
txtTypeR=nil;
txtNameR=nil;
txtContentR=nil;
picR=nil;
txtTimeR=nil;
iconR=nil;
view=nil;
end
----#End#----
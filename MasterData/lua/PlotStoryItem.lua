--剧情故事界面子物体
local content = "";
local fade = nil
local isLeader = false
local isShowIcon = false
local gradient = nil

function Awake()
	gradient=ComUtil.GetCom(icon,"UIImageGradient");
end

function Refresh(plot)
	if plot then
		CSAPI.SetGOActive(iconObj, false);
		if plot:GetKey() == "PlotData" then
			local talkName = ""
			isLeader = plot:IsLeader()
			isShowIcon = plot:GetShowStory() and plot:GetShowStory() == 2
			if plot:IsLeader() then --玩家正常对话
				talkName = PlayerClient:GetName()
				if PlayerClient:GetIconName() then
					CSAPI.SetGOActive(iconObj, true)
					ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true)
				end
			elseif plot:GetTalkName() ~= "" and plot:GetTalkName() ~= nil then
				talkName = plot:GetTalkName();
				--获取配置表头像
				CSAPI.SetGOActive(iconObj, isShowIcon)
				if isShowIcon then
					local talkInfo = plot:GetTalkInfo();
					ResUtil.RoleCard:Load(icon, talkInfo:GetIcon());
					-- CSAPI.SetRTSize(icon, 127, 127)

					local useGradient = plot:IsIconGradient()
					local iconGradient = talkInfo:GetIconGradient()
					if iconGradient and useGradient then
						iconGradient = iconGradient < 0 and 0 or iconGradient
						iconGradient = iconGradient> 100 and 100 or iconGradient
						SetIconGradient(iconGradient)
					end
				end
			end
			CSAPI.SetText(txt_name, talkName);
		else --玩家选项对话
			if PlayerClient:GetSex() > 0 then
				isLeader = true
				CSAPI.SetText(txt_name, PlayerClient:GetName());
				if PlayerClient:GetIconName() then
					CSAPI.SetGOActive(iconObj, true)
					ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true)
				end
			else
				CSAPI.SetText(txt_name, "？？？？");
			end
		end
		content = string.gsub(plot:GetContent(), "<[%p%w]->", "")
		content = string.gsub(content, "^%s*(.-)%s*$", "%1")
		CSAPI.SetText(txt_content1,"")
		CSAPI.SetText(txt_content2,"")
		local txtContent = (isLeader or isShowIcon) and txt_content2 or txt_content1
		CSAPI.SetText(txtContent, content);
	end
end

function GetHeight()
	local height = 45;
	local list = StringUtil:SubStrByLength(content, 46);
	height = height + 35 * (#list - 1);
	if isLeader or isShowIcon then
		height = height > 180 and height + (10 * (#list - 1)) or 180
	end
	return height;
end

function SetFadeIn(idx)
	idx = idx or 0
	if not fade then
		fade = ComUtil.GetCom(gameObject, "ActionFade")
	end
	fade:Play(0, 1, 250, idx * 100)
end
function OnDestroy()	
	ReleaseCSComRefs();
end

function SetIconGradient(num)
	local keys = {}
	if num then
		num = 100 - num
		table.insert(keys,{0, 100, 100, 100})
		table.insert(keys,{num, 0, 0, 0})
		table.insert(keys,{100, 0, 0, 0})
	else
		table.insert(keys,{0, 100, 100, 100})
		table.insert(keys,{100, 100, 100, 100})
	end
	gradient:SetGradientColor(keys)
	gradient.enabled = num ~= nil
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	iconObj = nil;
	icon = nil;
	txt_name = nil;
	txt_content = nil;
	view = nil;
end
----#End#----

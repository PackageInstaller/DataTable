local inpName = nil
local playerName = ""
local currLSel = 1
local itemId = 25001
local goodsData = nil
local isChangeName = false
local isChangeSex = false

function Awake()
    eventMgr = ViewEvent.New()
    -- eventMgr:AddListener(EventType.Player_EditName,OnNameChange)

    inpName = ComUtil.GetCom(inputName, "InputField");
    CSAPI.AddInputFieldChange(inputName, InputChange)
end

function InputChange(_str)
	_str = StringUtil:FilterChar(_str)
	local str = StringUtil:SetStringByLen(_str, 7)
	inpName.text = str
end

function OnNameChange()
    -- view:Close()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
	currLSel = PlayerClient:GetSex()
	goodsData = GoodsData({id = itemId})
	RefreshPanel()
end

function RefreshPanel()
	SetLeft()
	SetRight()
end

---------------------------------------------角色---------------------------------------------
function SetLeft()
	SetRole()
	SetLIcon()
end

function SetRole()
	local currSex = PlayerClient:GetSex()
	CSAPI.SetGOActive(txt_cur1,currSex == 1)
	CSAPI.SetGOActive(txt_cur2,currSex == 2)
    CSAPI.SetGOActive(selObj1,currLSel == 1)
	CSAPI.SetGOActive(selObj2,currLSel == 2)
	CSAPI.SetGOAlpha(iconParent1,currLSel == 1 and 1 or 0.5)
	CSAPI.SetGOAlpha(iconParent2,currLSel == 2 and 1 or 0.5)
end

function SetLIcon()
	local ids = g_SexInitCardIds
	if ids and #ids> 0 then
        for i, id in ipairs(ids) do
			if this["icon" .. i] then
				local cfg = Cfgs.CardData:GetByID(id);
				if cfg  then
					if cfg.model then
						local cfgModel = Cfgs.character:GetByID(cfg.model)
						if cfgModel and cfgModel.Card_head then
							ResUtil.CardIcon:Load(this["icon" .. i].gameObject,cfgModel.Card_head)
						end
					end
					if cfg.quality then
						ResUtil.RoleCard_BG:Load(this["frame" .. i], "btn_1_0" .. cfg.quality)
					end
				end
			end
        end
    end
end

function OnClickSex(go)
	if go.name == "btnMan" then
		currLSel = 1
	else
		currLSel = 2
	end
	SetRole()
end

---------------------------------------------姓名---------------------------------------------

function SetRight()
	SetName()
	SetItem()
end

function SetName()
	-- CSAPI.SetText(txtName,PlayerClient:GetName())
end

function SetItem()
	if goodsData then
		local iconName = goodsData:GetIcon()
		if iconName and iconName~="" then
			ResUtil.IconGoods:Load(goodIcon,iconName .."_1")
		end
		local num =BagMgr:GetCount(goodsData:GetID())
		CSAPI.SetText(txtNum,StringUtil:SetByColor(num.."/1", num >= 1 and "ffffff" or "ff7781"))
	end
end

function OnClickGoods()
	-- UIUtil:OpenGoodsInfo(goodsData, 3);
end
---------------------------------------------选择---------------------------------------------
function OnClickOK()
	playerName = inpName.text
	isChangeName = not (playerName == "" or playerName == PlayerClient:GetName())
	isChangeSex = currLSel ~= PlayerClient:GetSex()
	if CSAPI.IsADV() then
		local Len1 = GLogicCheck:GetStringLen(playerName)
		playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
		local Len2 = GLogicCheck:GetStringLen(playerName)
		if Len1 ~= Len2 then
			local dialogData = {}
			dialogData.content = LanguageMgr:GetTips(9011)
			dialogData.okCallBack = OnChangeNameAndSex()
			CSAPI.OpenView("Dialog",dialogData)
		else
			OnChangeNameAndSex()
		end
	else
		OnChangeNameAndSex()
	end
end

function OnChangeNameAndSex()
	if not CheckIsPass() then
		return 
	end

	local dialogData = {}
	dialogData.content = LanguageMgr:GetTips(30004)
	dialogData.okCallBack = function()
		if isChangeName then
			EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="name_change_check",time=1500,
			timeOutCallBack=function ()
				-- Tips.ShowTips("检查姓名超时,请点击重试！")
				LanguageMgr:ShowTips(6016)
			end});

			PlayerProto:PlrNameCheckUse({name = playerName},function(proto)
				EventMgr.Dispatch(EventType.Net_Msg_Getted,"name_change_check");
				if proto and proto.isUse ~= nil then
					if proto.isUse == false then
						local currMonth,currDay = PlayerClient:GetBirthDay()
						local data = {
							item_id = itemId,
							name = isChangeName and playerName or nil,
							index = isChangeSex and currLSel or nil,
							month = currMonth,
							day = currDay,
							use_vid = 1
						}
						PlayerProto:ChangePlrNameAndSex(data,function (proto)
							if proto.sex_ok == true then
								PlayerClient:SetSex(currLSel)
							end
							if proto.name_ok == true or proto.sex_ok == true then
								EventMgr.Dispatch(EventType.Player_SexOrName_Change)
							end
							view:Close()
						end)
					else
						Tips.ShowTips(LanguageMgr:GetByID(16076));
					end
				end
			end)
		else
			local currMonth,currDay = PlayerClient:GetBirthDay()
			local data = {
				item_id = itemId,
				name = isChangeName and playerName or nil,
				index = isChangeSex and currLSel or nil,
				month = currMonth,
				day = currDay,
				use_vid = 1
			}
			PlayerProto:ChangePlrNameAndSex(data,function (proto)
				if proto.sex_ok == true then
					PlayerClient:SetSex(currLSel)
				end
				if proto.name_ok == true or proto.sex_ok == true then
					EventMgr.Dispatch(EventType.Player_SexOrName_Change)
				end
				view:Close()
			end)
		end
	end
	CSAPI.OpenView("Dialog",dialogData)
end

function CheckIsPass()
	if IsEmoji(playerName) then
		Tips.ShowTips(LanguageMgr:GetByID(16064));
		return false
	end
    local b = MsgParser:CheckContain(playerName)
	if(b) then
		LanguageMgr:ShowTips(9003)
		return false
	end 

	if not isChangeName and not isChangeSex then
		Tips.ShowTips(LanguageMgr:GetByID(8035))
		return false
	end

	if BagMgr:GetCount(goodsData:GetID()) < 1 then
		local dialogData = {}
		dialogData.content = LanguageMgr:GetTips(30005)
		dialogData.okCallBack = function()
			if goodsData and goodsData:GetMoneyJumpID() then
				JumpMgr:Jump(goodsData:GetMoneyJumpID())
			end
		end
		CSAPI.OpenView("Dialog",dialogData)
		return false
	end

	return true
end

function IsEmoji(_str)
	local len = StringUtil:Utf8Len(_str)
	for i = 1, len do
		local str = StringUtil:Utf8Sub(_str, i, i)
		local byteLen = string.len(str)--编码占多少字节
		if byteLen > 3 then--超过三个字节的必须是emoji字符啊
			return true
		end
		
		if byteLen == 3 then
			if string.find(str, "[\226][\132-\173]") or string.find(str, "[\227][\128\138]") then
				return true--过滤部分三个字节表示的emoji字符，可能是早期的符号，用的还是三字节，坑。。。这里不保证完全正确，可能会过滤部分中文字。。。
			end
		end
		
		if byteLen == 1 then
			local ox = string.byte(str)
			if(33 <= ox and 47 >= ox) or(58 <= ox and 64 >= ox) or(91 <= ox and 96 >= ox) or(123 <= ox and 126 >= ox) or(str == "　") then
				return true--过滤ASCII字符中的部分标点，这里排除了空格，用编码来过滤有很好的扩展性，如果是标点可以直接用%p匹配。
			end
		end
	end
	return false
end

function OnClickCancel()
    view:Close()
end
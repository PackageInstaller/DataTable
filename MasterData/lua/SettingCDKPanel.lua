
local CurrStr = ""

function Awake()
	input = ComUtil.GetCom(InputField, "InputField")
end

function OnEnable()
	CSAPI.AddInputFieldChange(InputField, InputChange)
	CSAPI.AddInputFieldCallBack(InputField, InputCB)
	
	input.text = ""
end

function OnDisable()
	CSAPI.RemoveInputFieldChange(InputField, InputChange)
	CSAPI.RemoveInputFieldCallBack(InputField, InputCB)
end

function SetNums()
	local length, chars = GLogicCheck:GetStringLen(input.text)
	local strs = {}
	for i = 1, 5 do
		local str = ""
		for j = 1, 4 do
			local index = 4 *(i - 1) + j
			if(index <= length) then
				str = str .. chars[index]
			end
		end
		table.insert(strs, str)
	end
	local allTxts = {txt_1, txt_2, txt_3, txt_4, txt_5}
	for i, v in ipairs(allTxts) do
		local s = i <= #strs and strs[i] or ""
		CSAPI.SetText(v, s)
	end
end

function InputChange(str)
	LimitLen(str)
end

function InputCB(str)
	LimitLen(str)
end

function LimitLen(_str)
	local str = FilterChar(_str)
	local length, chars = GLogicCheck:GetStringLen(_str)
	-- local str = ""
	CSAPI.SetGOActive(dh_sel, length > 0)
	-- if(length > 20) then
	-- 	for i, v in ipairs(chars) do
	-- 		if(i <= 20) then
	-- 			str = str .. v
	-- 		end
	-- 	end
	-- else
	-- 	str = _str
	-- end
	CurrStr = str
	input.text = str
	-- SetNums()
end

function OnClickDH()
	if(CurrStr == nil or CurrStr == "") then
		LanguageMgr:ShowTips(7005)
		return
	end
	local length, chars = GLogicCheck:GetStringLen(CurrStr)
	if(length > 24) then
		LanguageMgr:ShowTips(7005)
		return
	end
	ClientProto:UseExchangeCode(GetNumsStr())
	input.text = ""
end

function GetNumsStr()
	local length, chars = GLogicCheck:GetStringLen(CurrStr)
	local str = CurrStr
	if length == 20 then
		local strs = {}
		for i = 1, 5 do
			local _str = ""
			for j = 1, 4 do
				local index = 4 *(i - 1) + j
				if(index <= length) then
					_str = _str .. chars[index]
				end
			end
			table.insert(strs, _str)
		end
		for i, v in ipairs(strs) do
			local s = i <= #strs and strs[i] or ""
			if(i == 1) then
				str = strs[i]
			else
				str = str .. "-" .. strs[i]
			end
		end
	end
	return str
end

function SetFade(isOpen, callback)
	CSAPI.SetGOActive(gameObject, isOpen)
	if callback then
		callback()
	end
end 

--保留数字，字母和“-”
function FilterChar(_str)
    -- 使用正则表达式匹配数字、字母和"-"符号
    local pattern = "[0-9a-zA-Z-]+"
    local str = ""
    
    for match in (_str):gmatch(pattern) do
        str = str .. match
    end
    
    return str
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
txtDhzx=nil;
txtDesc=nil;
txt_1=nil;
txt_1=nil;
txt_2=nil;
txt_2=nil;
txt_3=nil;
txt_3=nil;
txt_4=nil;
txt_4=nil;
txt_5=nil;
txt_5=nil;
InputField=nil;
curExp=nil;
dh_sel=nil;
view=nil;
end
----#End#----
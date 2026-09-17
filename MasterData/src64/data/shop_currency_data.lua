local var_0_0 = {}
local var_0_1 = {
	"data.shop.shop_clothes_currency_data",
	"data.shop.shop_currency_171_data",
	"data.shop.shop_currency_195_data",
	"data.shop.shop_currency_199_data",
	"data.shop.shop_currency_1_data",
	"data.shop.shop_currency_2024zq_data",
	"data.shop.shop_currency_207_data",
	"data.shop.shop_currency_217_data",
	"data.shop.shop_currency_225_data",
	"data.shop.shop_currency_227_data",
	"data.shop.shop_currency_228_data",
	"data.shop.shop_currency_232_data",
	"data.shop.shop_currency_238_data",
	"data.shop.shop_currency_248_data",
	"data.shop.shop_currency_252_data",
	"data.shop.shop_currency_275_data",
	"data.shop.shop_currency_68_data",
	"data.shop.shop_currency_70_data",
	"data.shop.shop_currency_71_data",
	"data.shop.shop_currency_72_data",
	"data.shop.shop_currency_730_data",
	"data.shop.shop_currency_731_data",
	"data.shop.shop_currency_73_data",
	"data.shop.shop_currency_745_data",
	"data.shop.shop_currency_74_data",
	"data.shop.shop_currency_755_data",
	"data.shop.shop_currency_758_data",
	"data.shop.shop_currency_766_data",
	"data.shop.shop_currency_767_data",
	"data.shop.shop_currency_775_data",
	"data.shop.shop_currency_776_data",
	"data.shop.shop_currency_787_data",
	"data.shop.shop_currency_792_data",
	"data.shop.shop_currency_805_data",
	"data.shop.shop_currency_806_data",
	"data.shop.shop_currency_811_data",
	"data.shop.shop_currency_813_data",
	"data.shop.shop_currency_830_data",
	"data.shop.shop_currency_837_data",
	"data.shop.shop_currency_838_data",
	"data.shop.shop_currency_83_data",
	"data.shop.shop_currency_846_data",
	"data.shop.shop_currency_84_data",
	"data.shop.shop_currency_855_data",
	"data.shop.shop_currency_85_data",
	"data.shop.shop_currency_861_data",
	"data.shop.shop_currency_865_data",
	"data.shop.shop_currency_866_data",
	"data.shop.shop_currency_868_data",
	"data.shop.shop_currency_869_data",
	"data.shop.shop_currency_872_data",
	"data.shop.shop_currency_876_data",
	"data.shop.shop_currency_881_data",
	"data.shop.shop_currency_887_data",
	"data.shop.shop_currency_888_data",
	"data.shop.shop_currency_891_data",
	"data.shop.shop_currency_892_data",
	"data.shop.shop_currency_894_data",
	"data.shop.shop_currency_896_data",
	"data.shop.shop_currency_897_data",
	"data.shop.shop_currency_PVE_data",
	"data.shop.shop_currency_awl_data",
	"data.shop.shop_currency_basic_birthday_data",
	"data.shop.shop_currency_basic_data",
	"data.shop.shop_currency_bianhua_data",
	"data.shop.shop_currency_christmas148_data",
	"data.shop.shop_currency_double11_data",
	"data.shop.shop_currency_family_data",
	"data.shop.shop_currency_favor_data",
	"data.shop.shop_currency_furniture_data",
	"data.shop.shop_currency_gift_data",
	"data.shop.shop_currency_guanggunZZ_data",
	"data.shop.shop_currency_helloweenZZ_data",
	"data.shop.shop_currency_helloween_data",
	"data.shop.shop_currency_lamia_data",
	"data.shop.shop_currency_marry4_data",
	"data.shop.shop_currency_monopoly_data",
	"data.shop.shop_currency_old_sub_data",
	"data.shop.shop_currency_overclock_data",
	"data.shop.shop_currency_question_pt_data",
	"data.shop.shop_currency_saya_180_data",
	"data.shop.shop_currency_skintwist_data",
	"data.shop.shop_currency_spring154_data",
	"data.shop.shop_currency_spring_festival_data",
	"data.shop.shop_currency_stable_173_data",
	"data.shop.shop_currency_suzuran_182_data",
	"data.shop.shop_currency_teacher2021_data",
	"data.shop.shop_currency_tft_data",
	"data.shop.shop_currency_twistmarry_data",
	"data.shop.shop_currency_umaru_data",
	"data.shop.shop_currency_yuandancount157_data",
	"data.shop.shop_currency_yuanxiao_156_data",
	"data.shop.shop_currency_zhounian_data",
	"data.shop.shop_jinxiu2_currency_data",
	"data.shop.shop_marry_currency_data"
}

if DeviceManager.platform == "windows" then
	local var_0_2 = {}

	for iter_0_0, iter_0_1 in ipairs(var_0_1) do
		for iter_0_2, iter_0_3 in pairs((require(iter_0_1))) do
			if var_0_2[iter_0_2] then
				error(iter_0_2 .. " is conflict between " .. var_0_2[iter_0_2] .. " and " .. iter_0_1 .. ", 快叫凯达去改表")
			else
				var_0_2[iter_0_2] = iter_0_1
			end
		end
	end
end

for iter_0_4, iter_0_5 in pairs(var_0_1) do
	table.merge(var_0_0, (require(iter_0_5)))
end

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			print("shop_currency_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0

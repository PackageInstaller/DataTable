-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/ToLua/Lua/jit/dis_arm.lua

local type = type
local sub, byte, format = string.sub, string.byte, string.format
local match, gmatch = string.match, string.gmatch
local concat = table.concat
local bit = require("bit")
local band, bor, ror, tohex = bit.band, bit.bor, bit.ror, bit.tohex
local lshift, rshift, arshift = bit.lshift, bit.rshift, bit.arshift
local map_loadc = {
	shift = 8,
	mask = 15,
	[10] = {
		[0] = {
			[0] = "vmovFmDN",
			"vstmFNdr",
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vstrFdl",
				{
					[13] = "vpushFdr",
					_ = "vstmdbFNdr",
					shift = 16,
					mask = 15
				},
				shift = 21,
				mask = 1
			}
		},
		{
			[0] = "vmovFDNm",
			{
				[13] = "vpopFdr",
				_ = "vldmFNdr",
				shift = 16,
				mask = 15
			},
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vldrFdl",
				"vldmdbFNdr",
				shift = 21,
				mask = 1
			}
		},
		shift = 20,
		mask = 1
	},
	[11] = {
		[0] = {
			[0] = "vmovGmDN",
			"vstmGNdr",
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vstrGdl",
				{
					[13] = "vpushGdr",
					_ = "vstmdbGNdr",
					shift = 16,
					mask = 15
				},
				shift = 21,
				mask = 1
			}
		},
		{
			[0] = "vmovGDNm",
			{
				[13] = "vpopGdr",
				_ = "vldmGNdr",
				shift = 16,
				mask = 15
			},
			shift = 23,
			mask = 3,
			_ = {
				[0] = "vldrGdl",
				"vldmdbGNdr",
				shift = 21,
				mask = 1
			}
		},
		shift = 20,
		mask = 1
	},
	_ = {
		shift = 0,
		mask = 0
	}
}
local map_vfps = {
	[0] = "vmlaF.dnm",
	"vmlsF.dnm",
	[147456] = "vfnmsF.dnm",
	[163840] = "vfmaF.dnm",
	[131072] = "vdivF.dnm",
	mask = 180225,
	[32769] = "vnmulF.dnm",
	[16384] = "vnmlsF.dnm",
	[32768] = "vmulF.dnm",
	[16385] = "vnmlaF.dnm",
	[163841] = "vfmsF.dnm",
	[180224] = "vmovF.dY",
	[49153] = "vsubF.dnm",
	[49152] = "vaddF.dnm",
	shift = 6,
	[147457] = "vfnmaF.dnm",
	[180225] = {
		[0] = "vmovF.dm",
		"vabsF.dm",
		[512] = "vnegF.dm",
		[2048] = "vcmpF.dm",
		[4096] = "vcvt.f32.u32Fdm",
		mask = 7681,
		[513] = "vsqrtF.dm",
		[2560] = "vcmpzF.d",
		[2049] = "vcmpeF.dm",
		[4097] = "vcvt.f32.s32Fdm",
		[6144] = "vcvtr.u32F.dm",
		[2561] = "vcmpzeF.d",
		[6656] = "vcvtr.s32F.dm",
		[6145] = "vcvt.u32F.dm",
		[6657] = "vcvt.s32F.dm",
		shift = 7,
		[3585] = "vcvtG.dF.m"
	}
}
local map_vfpd = {
	[0] = "vmlaG.dnm",
	"vmlsG.dnm",
	[147456] = "vfnmsG.dnm",
	[163840] = "vfmaG.dnm",
	[131072] = "vdivG.dnm",
	mask = 180225,
	[32769] = "vnmulG.dnm",
	[16384] = "vnmlsG.dnm",
	[32768] = "vmulG.dnm",
	[16385] = "vnmlaG.dnm",
	[163841] = "vfmsG.dnm",
	[180224] = "vmovG.dY",
	[49153] = "vsubG.dnm",
	[49152] = "vaddG.dnm",
	shift = 6,
	[147457] = "vfnmaG.dnm",
	[180225] = {
		[0] = "vmovG.dm",
		"vabsG.dm",
		[512] = "vnegG.dm",
		[2048] = "vcmpG.dm",
		[4096] = "vcvt.f64.u32GdFm",
		mask = 7681,
		[513] = "vsqrtG.dm",
		[2560] = "vcmpzG.d",
		[2049] = "vcmpeG.dm",
		[4097] = "vcvt.f64.s32GdFm",
		[6144] = "vcvtr.u32FdG.m",
		[2561] = "vcmpzeG.d",
		[6656] = "vcvtr.s32FdG.m",
		[6145] = "vcvt.u32FdG.m",
		[6657] = "vcvt.s32FdG.m",
		shift = 7,
		[3585] = "vcvtF.dG.m"
	}
}
local map_datac = {
	"svcT",
	shift = 24,
	mask = 1,
	[0] = {
		[0] = {
			shift = 8,
			mask = 15,
			[10] = map_vfps,
			[11] = map_vfpd
		},
		{
			shift = 8,
			mask = 15,
			[10] = {
				[0] = "vmovFnD",
				"vmovFDn",
				[14] = "vmsrD",
				shift = 20,
				mask = 15,
				[15] = {
					_ = "vmrsD",
					[15] = "vmrs",
					shift = 12,
					mask = 15
				}
			}
		},
		shift = 4,
		mask = 1
	}
}
local map_loadcu = {
	shift = 0,
	mask = 0
}
local map_datacu = {
	shift = 0,
	mask = 0
}
local map_simddata = {
	shift = 0,
	mask = 0
}
local map_simdload = {
	shift = 0,
	mask = 0
}
local map_preload = {
	shift = 0,
	mask = 0
}
local map_media = {
	[0] = false,
	{
		[0] = "sadd16DNM",
		"sasxDNM",
		"ssaxDNM",
		"ssub16DNM",
		"sadd8DNM",
		false,
		false,
		"ssub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "qadd16DNM",
		"qasxDNM",
		"qsaxDNM",
		"qsub16DNM",
		"qadd8DNM",
		false,
		false,
		"qsub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "shadd16DNM",
		"shasxDNM",
		"shsaxDNM",
		"shsub16DNM",
		"shadd8DNM",
		false,
		false,
		"shsub8DNM",
		shift = 5,
		mask = 7
	},
	false,
	{
		[0] = "uadd16DNM",
		"uasxDNM",
		"usaxDNM",
		"usub16DNM",
		"uadd8DNM",
		false,
		false,
		"usub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "uqadd16DNM",
		"uqasxDNM",
		"uqsaxDNM",
		"uqsub16DNM",
		"uqadd8DNM",
		false,
		false,
		"uqsub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "uhadd16DNM",
		"uhasxDNM",
		"uhsaxDNM",
		"uhsub16DNM",
		"uhadd8DNM",
		false,
		false,
		"uhsub8DNM",
		shift = 5,
		mask = 7
	},
	{
		[0] = "pkhbtDNMU",
		false,
		"pkhtbDNMU",
		{
			_ = "sxtab16DNMU",
			[15] = "sxtb16DMU",
			shift = 16,
			mask = 15
		},
		"pkhbtDNMU",
		"selDNM",
		"pkhtbDNMU",
		shift = 5,
		mask = 7
	},
	false,
	{
		[0] = "ssatDxMu",
		"ssat16DxM",
		"ssatDxMu",
		{
			_ = "sxtabDNMU",
			[15] = "sxtbDMU",
			shift = 16,
			mask = 15
		},
		"ssatDxMu",
		false,
		"ssatDxMu",
		shift = 5,
		mask = 7
	},
	{
		[0] = "ssatDxMu",
		"revDM",
		"ssatDxMu",
		{
			_ = "sxtahDNMU",
			[15] = "sxthDMU",
			shift = 16,
			mask = 15
		},
		"ssatDxMu",
		"rev16DM",
		"ssatDxMu",
		shift = 5,
		mask = 7
	},
	{
		shift = 5,
		mask = 7,
		[3] = {
			_ = "uxtab16DNMU",
			[15] = "uxtb16DMU",
			shift = 16,
			mask = 15
		}
	},
	false,
	{
		[0] = "usatDwMu",
		"usat16DwM",
		"usatDwMu",
		{
			_ = "uxtabDNMU",
			[15] = "uxtbDMU",
			shift = 16,
			mask = 15
		},
		"usatDwMu",
		false,
		"usatDwMu",
		shift = 5,
		mask = 7
	},
	{
		[0] = "usatDwMu",
		"rbitDM",
		"usatDwMu",
		{
			_ = "uxtahDNMU",
			[15] = "uxthDMU",
			shift = 16,
			mask = 15
		},
		"usatDwMu",
		"revshDM",
		"usatDwMu",
		shift = 5,
		mask = 7
	},
	{
		shift = 12,
		mask = 15,
		[15] = {
			"smuadNMS",
			"smuadxNMS",
			"smusdNMS",
			"smusdxNMS",
			shift = 5,
			mask = 7
		},
		_ = {
			[0] = "smladNMSD",
			"smladxNMSD",
			"smlsdNMSD",
			"smlsdxNMSD",
			shift = 5,
			mask = 7
		}
	},
	false,
	false,
	false,
	{
		[0] = "smlaldDNMS",
		"smlaldxDNMS",
		"smlsldDNMS",
		"smlsldxDNMS",
		shift = 5,
		mask = 7
	},
	{
		[0] = {
			_ = "smmlaNMSD",
			[15] = "smmulNMS",
			shift = 12,
			mask = 15
		},
		{
			_ = "smmlarNMSD",
			[15] = "smmulrNMS",
			shift = 12,
			mask = 15
		},
		false,
		false,
		false,
		false,
		"smmlsNMSD",
		"smmlsrNMSD",
		shift = 5,
		mask = 7
	},
	false,
	false,
	{
		shift = 5,
		mask = 7,
		[0] = {
			_ = "usada8NMSD",
			[15] = "usad8NMS",
			shift = 12,
			mask = 15
		}
	},
	false,
	{
		nil,
		"sbfxDMvw",
		shift = 5,
		mask = 3
	},
	{
		nil,
		"sbfxDMvw",
		shift = 5,
		mask = 3
	},
	{
		shift = 5,
		mask = 3,
		[0] = {
			_ = "bfiDMvX",
			[15] = "bfcDvX",
			shift = 0,
			mask = 15
		}
	},
	{
		shift = 5,
		mask = 3,
		[0] = {
			_ = "bfiDMvX",
			[15] = "bfcDvX",
			shift = 0,
			mask = 15
		}
	},
	{
		nil,
		"ubfxDMvw",
		shift = 5,
		mask = 3
	},
	{
		nil,
		"ubfxDMvw",
		shift = 5,
		mask = 3
	},
	shift = 20,
	mask = 31
}
local map_load = {
	{
		[0] = "strtDL",
		"ldrtDL",
		nil,
		nil,
		"strbtDL",
		"ldrbtDL",
		shift = 20,
		mask = 5
	},
	shift = 21,
	mask = 9,
	_ = {
		[0] = "strDL",
		"ldrDL",
		nil,
		nil,
		"strbDL",
		"ldrbDL",
		shift = 20,
		mask = 5
	}
}
local map_load1 = {
	[0] = map_load,
	map_media,
	shift = 4,
	mask = 1
}
local map_loadm = {
	[0] = {
		[0] = "stmdaNR",
		"stmNR",
		{
			[45] = "pushR",
			_ = "stmdbNR",
			shift = 16,
			mask = 63
		},
		"stmibNR",
		shift = 23,
		mask = 3
	},
	{
		[0] = "ldmdaNR",
		{
			_ = "ldmNR",
			[61] = "popR",
			shift = 16,
			mask = 63
		},
		"ldmdbNR",
		"ldmibNR",
		shift = 23,
		mask = 3
	},
	shift = 20,
	mask = 1
}
local map_data = {
	[0] = "andDNPs",
	"eorDNPs",
	"subDNPs",
	"rsbDNPs",
	"addDNPs",
	"adcDNPs",
	"sbcDNPs",
	"rscDNPs",
	"tstNP",
	"teqNP",
	"cmpNP",
	"cmnNP",
	"orrDNPs",
	"movDPs",
	"bicDNPs",
	"mvnDPs",
	shift = 21,
	mask = 15
}
local map_mul = {
	[0] = "mulNMSs",
	"mlaNMSDs",
	"umaalDNMS",
	"mlsDNMS",
	"umullDNMSs",
	"umlalDNMSs",
	"smullDNMSs",
	"smlalDNMSs",
	shift = 21,
	mask = 7
}
local map_sync = {
	[0] = "swpDMN",
	false,
	false,
	false,
	"swpbDMN",
	false,
	false,
	false,
	"strexDMN",
	"ldrexDN",
	"strexdDN",
	"ldrexdDN",
	"strexbDMN",
	"ldrexbDN",
	"strexhDN",
	"ldrexhDN",
	shift = 20,
	mask = 15
}
local map_mulh = {
	[0] = {
		[0] = "smlabbNMSD",
		"smlatbNMSD",
		"smlabtNMSD",
		"smlattNMSD",
		shift = 5,
		mask = 3
	},
	{
		[0] = "smlawbNMSD",
		"smulwbNMS",
		"smlawtNMSD",
		"smulwtNMS",
		shift = 5,
		mask = 3
	},
	{
		[0] = "smlalbbDNMS",
		"smlaltbDNMS",
		"smlalbtDNMS",
		"smlalttDNMS",
		shift = 5,
		mask = 3
	},
	{
		[0] = "smulbbNMS",
		"smultbNMS",
		"smulbtNMS",
		"smulttNMS",
		shift = 5,
		mask = 3
	},
	shift = 21,
	mask = 3
}
local map_misc = {
	[0] = {
		[0] = "mrsD",
		"msrM",
		shift = 21,
		mask = 1
	},
	{
		"bxM",
		false,
		"clzDM",
		shift = 21,
		mask = 3
	},
	{
		"bxjM",
		shift = 21,
		mask = 3
	},
	{
		"blxM",
		shift = 21,
		mask = 3
	},
	false,
	{
		[0] = "qaddDMN",
		"qsubDMN",
		"qdaddDMN",
		"qdsubDMN",
		shift = 21,
		mask = 3
	},
	false,
	{
		"bkptK",
		shift = 21,
		mask = 3
	},
	shift = 4,
	mask = 7
}
local map_datar = {
	shift = 4,
	mask = 9,
	[9] = {
		[0] = {
			[0] = map_mul,
			map_sync,
			shift = 24,
			mask = 1
		},
		{
			[0] = "strhDL",
			"ldrhDL",
			shift = 20,
			mask = 1
		},
		{
			[0] = "ldrdDL",
			"ldrsbDL",
			shift = 20,
			mask = 1
		},
		{
			[0] = "strdDL",
			"ldrshDL",
			shift = 20,
			mask = 1
		},
		shift = 5,
		mask = 3
	},
	_ = {
		shift = 20,
		mask = 25,
		[16] = {
			[0] = map_misc,
			map_mulh,
			shift = 7,
			mask = 1
		},
		_ = {
			shift = 0,
			mask = 4294967295,
			[bor(3785359360)] = "nop",
			_ = map_data
		}
	}
}
local map_datai = {
	[16] = "movwDW",
	mask = 31,
	[20] = "movtDW",
	shift = 20,
	[22] = "msrNW",
	[18] = {
		[0] = "nopv6",
		_ = "msrNW",
		shift = 0,
		mask = 983295
	},
	_ = map_data
}
local map_branch = {
	[0] = "bB",
	"blB",
	shift = 24,
	mask = 1
}
local map_condins = {
	[0] = map_datar,
	map_datai,
	map_load,
	map_load1,
	map_loadm,
	map_branch,
	map_loadc,
	map_datac
}
local map_uncondins = {
	[0] = false,
	map_simddata,
	map_simdload,
	map_preload,
	false,
	"blxB",
	map_loadcu,
	map_datacu
}
local map_gpr = {
	[0] = "r0",
	"r1",
	"r2",
	"r3",
	"r4",
	"r5",
	"r6",
	"r7",
	"r8",
	"r9",
	"r10",
	"r11",
	"r12",
	"sp",
	"lr",
	"pc"
}
local map_cond = {
	[0] = "eq",
	"ne",
	"hs",
	"lo",
	"mi",
	"pl",
	"vs",
	"vc",
	"hi",
	"ls",
	"ge",
	"lt",
	"gt",
	"le",
	"al"
}
local map_shift = {
	[0] = "lsl",
	"lsr",
	"asr",
	"ror"
}

local function putop(ctx, text, operands)
	local pos = ctx.pos
	local extra = ""

	if ctx.rel then
		local sym = ctx.symtab[ctx.rel]

		if sym then
			extra = "\t->" .. sym
		elseif band(ctx.op, 234881024) ~= 167772160 then
			extra = "\t; 0x" .. tohex(ctx.rel)
		end
	end

	if ctx.hexdump > 0 then
		ctx.out(format("%08x  %s  %-5s %s%s\n", ctx.addr + pos, tohex(ctx.op), text, concat(operands, ", "), extra))
	else
		ctx.out(format("%08x  %-5s %s%s\n", ctx.addr + pos, text, concat(operands, ", "), extra))
	end

	ctx.pos = pos + 4
end

local function unknown(ctx)
	return putop(ctx, ".long", {
		"0x" .. tohex(ctx.op)
	})
end

local function fmtload(ctx, op, pos)
	local base = map_gpr[band(rshift(op, 16), 15)]
	local x, ofs
	local ext = band(op, 67108864) == 0

	if not ext and band(op, 33554432) == 0 then
		ofs = band(op, 4095)

		if band(op, 8388608) == 0 then
			ofs = -ofs
		end

		if base == "pc" then
			ctx.rel = ctx.addr + pos + 8 + ofs
		end

		ofs = "#" .. ofs
	elseif ext and band(op, 4194304) ~= 0 then
		ofs = band(op, 15) + band(rshift(op, 4), 240)

		if band(op, 8388608) == 0 then
			ofs = -ofs
		end

		if base == "pc" then
			ctx.rel = ctx.addr + pos + 8 + ofs
		end

		ofs = "#" .. ofs
	else
		ofs = map_gpr[band(op, 15)]

		if ext or band(op, 4064) == 0 then
			-- block empty
		elseif band(op, 4064) == 96 then
			ofs = format("%s, rrx", ofs)
		else
			local sh = band(rshift(op, 7), 31)

			if sh == 0 then
				sh = 32
			end

			ofs = format("%s, %s #%d", ofs, map_shift[band(rshift(op, 5), 3)], sh)
		end

		if band(op, 8388608) == 0 then
			ofs = "-" .. ofs
		end
	end

	x = ofs == "#0" and format("[%s]", base) or band(op, 16777216) == 0 and format("[%s], %s", base, ofs) or format("[%s, %s]", base, ofs)

	if band(op, 18874368) == 18874368 then
		x = x .. "!"
	end

	return x
end

local function fmtvload(ctx, op, pos)
	local base = map_gpr[band(rshift(op, 16), 15)]
	local ofs = band(op, 255) * 4

	if band(op, 8388608) == 0 then
		ofs = -ofs
	end

	if base == "pc" then
		ctx.rel = ctx.addr + pos + 8 + ofs
	end

	if ofs == 0 then
		return format("[%s]", base)
	else
		return format("[%s, #%d]", base, ofs)
	end
end

local function fmtvr(op, vr, sh0, sh1)
	if vr == "s" then
		return format("s%d", 2 * band(rshift(op, sh0), 15) + band(rshift(op, sh1), 1))
	else
		return format("d%d", band(rshift(op, sh0), 15) + band(rshift(op, sh1 - 4), 16))
	end
end

local function disass_ins(ctx)
	local pos = ctx.pos
	local b0, b1, b2, b3 = byte(ctx.code, pos + 1, pos + 4)
	local op = bor(lshift(b3, 24), lshift(b2, 16), lshift(b1, 8), b0)
	local operands = {}
	local suffix = ""
	local last, name, pat, vr

	ctx.op = op
	ctx.rel = nil

	local cond = rshift(op, 28)
	local opat

	if cond == 15 then
		opat = map_uncondins[band(rshift(op, 25), 7)]
	else
		if cond ~= 14 then
			suffix = map_cond[cond]
		end

		opat = map_condins[band(rshift(op, 25), 7)]
	end

	while type(opat) ~= "string" do
		if not opat then
			return unknown(ctx)
		end

		opat = opat[band(rshift(op, opat.shift), opat.mask)] or opat._
	end

	name, pat = match(opat, "^([a-z0-9]*)(.*)")

	if sub(pat, 1, 1) == "." then
		local s2, p2 = match(pat, "^([a-z0-9.]*)(.*)")

		suffix = suffix .. s2
		pat = p2
	end

	for p in gmatch(pat, ".") do
		local x

		if p == "D" then
			x = map_gpr[band(rshift(op, 12), 15)]
		elseif p == "N" then
			x = map_gpr[band(rshift(op, 16), 15)]
		elseif p == "S" then
			x = map_gpr[band(rshift(op, 8), 15)]
		elseif p == "M" then
			x = map_gpr[band(op, 15)]
		elseif p == "d" then
			x = fmtvr(op, vr, 12, 22)
		elseif p == "n" then
			x = fmtvr(op, vr, 16, 7)
		elseif p == "m" then
			x = fmtvr(op, vr, 0, 5)
		elseif p == "P" then
			if band(op, 33554432) ~= 0 then
				x = ror(band(op, 255), 2 * band(rshift(op, 8), 15))
			else
				x = map_gpr[band(op, 15)]

				if band(op, 4080) ~= 0 then
					operands[#operands + 1] = x

					local s = map_shift[band(rshift(op, 5), 3)]
					local r

					if band(op, 3984) == 0 then
						if s == "ror" then
							s = "rrx"
						else
							r = "#32"
						end
					else
						r = band(op, 16) == 0 and "#" .. band(rshift(op, 7), 31) or map_gpr[band(rshift(op, 8), 15)]
					end

					if name == "mov" then
						name = s
						x = r
					else
						x = r and format("%s %s", s, r) or s
					end
				end
			end
		elseif p == "L" then
			x = fmtload(ctx, op, pos)
		elseif p == "l" then
			x = fmtvload(ctx, op, pos)
		elseif p == "B" then
			local addr = ctx.addr + pos + 8 + arshift(lshift(op, 8), 6)

			if cond == 15 then
				addr = addr + band(rshift(op, 23), 2)
			end

			ctx.rel = addr
			x = "0x" .. tohex(addr)
		elseif p == "F" then
			vr = "s"
		elseif p == "G" then
			vr = "d"
		elseif p == "." then
			suffix = suffix .. (vr == "s" and ".f32" or ".f64")
		elseif p == "R" then
			if band(op, 2097152) ~= 0 and #operands == 1 then
				operands[1] = operands[1] .. "!"
			end

			local t = {}

			for i = 0, 15 do
				if band(rshift(op, i), 1) == 1 then
					t[#t + 1] = map_gpr[i]
				end
			end

			x = "{" .. concat(t, ", ") .. "}"
		elseif p == "r" then
			if band(op, 2097152) ~= 0 and #operands == 2 then
				operands[1] = operands[1] .. "!"
			end

			local s = tonumber(sub(last, 2))
			local n = band(op, 255)

			if vr == "d" then
				n = rshift(n, 1)
			end

			operands[#operands] = format("{%s-%s%d}", last, vr, s + n - 1)
		elseif p == "W" then
			x = band(op, 4095) + band(rshift(op, 4), 61440)
		elseif p == "T" then
			x = "#0x" .. tohex(band(op, 16777215), 6)
		elseif p == "U" then
			x = band(rshift(op, 7), 31)

			if x == 0 then
				x = nil
			end
		elseif p == "u" then
			x = band(rshift(op, 7), 31)

			if band(op, 64) == 0 then
				if x == 0 then
					x = nil
				else
					x = "lsl #" .. x
				end
			else
				x = x == 0 and "asr #32" or "asr #" .. x
			end
		elseif p == "v" then
			x = band(rshift(op, 7), 31)
		elseif p == "w" then
			x = band(rshift(op, 16), 31)
		elseif p == "x" then
			x = band(rshift(op, 16), 31) + 1
		elseif p == "X" then
			x = band(rshift(op, 16), 31) - last + 1
		elseif p == "Y" then
			x = band(rshift(op, 12), 240) + band(op, 15)
		elseif p == "K" then
			x = "#0x" .. tohex(band(rshift(op, 4), 65520) + band(op, 15), 4)
		elseif p == "s" then
			if band(op, 1048576) ~= 0 then
				suffix = "s" .. suffix
			end
		else
			assert(false)
		end

		if x then
			last = x

			if type(x) == "number" then
				x = "#" .. x
			end

			operands[#operands + 1] = x
		end
	end

	return putop(ctx, name .. suffix, operands)
end

local function disass_block(ctx, ofs, len)
	ofs = ofs or 0

	if len then
		if not (ofs + len) then
			local stop = #ctx.code

			ctx.pos = ofs
			ctx.rel = nil

			while stop > ctx.pos do
				disass_ins(ctx)
			end
		end
	end
end

local function create(code, addr, out)
	local ctx = {}

	ctx.code = code
	ctx.addr = addr or 0
	ctx.out = out or io.write
	ctx.symtab = {}
	ctx.disass = disass_block
	ctx.hexdump = 8

	return ctx
end

local function disass(code, addr, out)
	create(code, addr, out):disass()
end

local function regname(r)
	if r < 16 then
		return map_gpr[r]
	end

	return "d" .. r - 16
end

return {
	create = create,
	disass = disass,
	regname = regname
}

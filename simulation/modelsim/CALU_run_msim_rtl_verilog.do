transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/muslim/HDD/Comlpex_ALU {/home/muslim/HDD/Comlpex_ALU/carry_look_ahead_16bit.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/Comlpex_ALU {/home/muslim/HDD/Comlpex_ALU/carry_look_ahead_4bit.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/Comlpex_ALU {/home/muslim/HDD/Comlpex_ALU/singed_multiplier.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/Comlpex_ALU {/home/muslim/HDD/Comlpex_ALU/sqrt_16bit.v}
vlog -vlog01compat -work work +incdir+/home/muslim/HDD/Comlpex_ALU {/home/muslim/HDD/Comlpex_ALU/magnitude.v}

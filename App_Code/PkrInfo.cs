using Newtonsoft.Json;

namespace Ado
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PkrInfo")]
    public partial class PkrInfo
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PkrID { get; set; }

        [Required]
        [StringLength(16)]
        public string PkrName { get; set; }

        public int PkzID { get; set; }

        public int PkcID { get; set; }

        public int HZID { get; set; }

        [Required]
        [StringLength(2)]
        public string Gender { get; set; }

        public int? Age { get; set; }

        [StringLength(16)]
        public string Education { get; set; }

        [StringLength(16)]
        public string IsDisabled { get; set; }

        [StringLength(128)]
        public string Home { get; set; }

        [Required]
        [StringLength(2)]
        public string IsHuzhu { get; set; }

        [StringLength(8)]
        public string Relationship { get; set; }

        public int? TotalNumberR { get; set; }

        [StringLength(4)]
        public string TpYear { get; set; }

        [StringLength(4)]
        public string YtpYear { get; set; }

        [Required]
        [StringLength(10)]
        public string IsTp { get; set; }

        [StringLength(64)]
        public string TpReason { get; set; }

        [StringLength(32)]
        public string BbrInfo { get; set; }

        public int? PhotovoltaicIncome { get; set; }

        public int? CultureIncome { get; set; }

        public int? BasicIncome { get; set; }

        public int? subsidyIncome { get; set; }
        [JsonIgnore]
        public virtual PkcInfo PkcInfo { get; set; }
        [JsonIgnore]
        public virtual PkzInfo PkzInfo { get; set; }
    }
}

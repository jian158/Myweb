using Newtonsoft.Json;

namespace Ado
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PkcInfo")]
    public partial class PkcInfo
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PkcInfo()
        {
            PkrInfo = new HashSet<PkrInfo>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PkcID { get; set; }

        [Required]
        [StringLength(32)]
        public string PkcName { get; set; }

        public int PkzID { get; set; }

        [StringLength(4)]
        public string PkcYear { get; set; }

        [StringLength(64)]
        public string PkcIndustry { get; set; }

        [StringLength(64)]
        public string PkcMember { get; set; }

        public int? TotalNumberH { get; set; }

        public int? TotalNumberR { get; set; }

        public int? PhotovoltaicIncome { get; set; }

        public int? CultureIncome { get; set; }

        public int? BasicIncome { get; set; }

        public int? subsidyIncome { get; set; }

        [JsonIgnore]
        public virtual PkzInfo PkzInfo { get; set; }

        [JsonIgnore]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PkrInfo> PkrInfo { get; set; }
    }
}
